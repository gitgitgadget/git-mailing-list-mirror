From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 11:45:52 -0500
Message-ID: <GwKOGVPR0AVw4_Phmw1TSNzzMDtafrawMMahm2DQwh44k6uTOHkjTQ@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil> <871w09kvew.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?RGF2aWQgS8OlZ2VkYWw=?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Aug 28 18:48:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYkeJ-0003KG-Sv
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 18:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbYH1QqD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 12:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbYH1QqC
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 12:46:02 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39102 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbYH1QqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 12:46:00 -0400
Received: by mail.nrlssc.navy.mil id m7SGjrpC014308; Thu, 28 Aug 2008 11:45:53 -0500
In-Reply-To: <871w09kvew.fsf@lysator.liu.se>
X-OriginalArrivalTime: 28 Aug 2008 16:45:52.0528 (UTC) FILETIME=[8883B100:01C9092D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94083>

David K=C3=A5gedal wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>=20
>> The following syntax:
>>
>>         char foo[] =3D {
>>                 [0] =3D 1,
>>                 [7] =3D 2,
>>                 [15] =3D 3
>>         };
>>
>> is a c99 construct which some compilers do not support even though t=
hey
>> support other c99 constructs. Use an alternative.
>=20
> But the alternative is much worse.

_Much_ worse? In what way?

=46rom an execution standpoint, I don't think any more work is performe=
d.
Probably exactly the same amount of work.

=46rom a readability standpoint, I think it is very nearly the same in
this case. The whole function is only 17 lines.

> So how important is it to support non-C99 compilers?

I think it is relative to the amount of effort it takes. If there is
a demonstrated need and a trivial work around, I think it is worth
it to support non-c99 compilers. Demonstrated need is required.

But, saying that, I posted the patch you replied to in a series that
was for informational purposes only (though I could have done a better
job labeling them). There were no comments from anyone who said that
the series solved any problems they were encountering. At some point
I will post an update.

-brandon
