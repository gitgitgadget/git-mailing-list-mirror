From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Any way to get complete diff up to a tag?
Date: Thu, 6 May 2010 15:00:50 +0200
Message-ID: <h2iadf1fd3d1005060600x95fc0e34m91b1697fc6f1789e@mail.gmail.com>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com>
	 <20100506094212.GB9921@atjola.homenet>
	 <A612847CFE53224C91B23E3A5B48BAC74482E50DE7@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu May 06 15:01:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA0hK-0004to-8M
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 15:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044Ab0EFNA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 09:00:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34854 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab0EFNA4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 09:00:56 -0400
Received: by fxm10 with SMTP id 10so5088767fxm.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 06:00:54 -0700 (PDT)
Received: by 10.103.205.23 with SMTP id h23mr12170459muq.88.1273150850696; 
	Thu, 06 May 2010 06:00:50 -0700 (PDT)
Received: by 10.103.178.17 with HTTP; Thu, 6 May 2010 06:00:50 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74482E50DE7@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146478>

2010/5/6 Peter Kjellerstedt <peter.kjellerstedt@axis.com>:
>> -----Original Message-----
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] O=
n
>> Behalf Of Bj=F6rn Steinbrink
>>
>> On 2010.05.06 11:27:40 +0200, Peter Kjellerstedt wrote:
>> > If I use
>> >
>> > $ git diff $(git rev-list --reverse v1.7.1 |head -1)..v1.7.1
>> >
>> > I almost get what I want, but the initial commit is still missing.
>> > Is there any way to get that initial commit included in the diff?
>>
>> git internally knows about the empty tree, so you can use:
>> git diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904 v1.7.1
>>
>> Bj=F6rn
>
> Thank you, that was useful. However, I need to be able to do this
> for an arbitrary repository, and that SHA seems to be specific for
> the git repository. How do I get the SHA for the empty tree in an
> arbitrary repository?

It is not specific for the git repository, there is only one SHA1 for
the empty tree. But it is hard-coded in git itself since 1.5.5. If you
use an older git you have to create it yourself.

Santi
