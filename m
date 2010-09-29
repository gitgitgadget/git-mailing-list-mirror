From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/18] git notes merge
Date: Wed, 29 Sep 2010 17:16:52 +0200
Message-ID: <201009291716.52831.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net> <AANLkTi=gL_6ueBvO7URth-rbbHyZLpwYEAMwErh1ciba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 17:18:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0yQg-00011Y-Os
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 17:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab0I2PSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 11:18:41 -0400
Received: from smtp.opera.com ([213.236.208.81]:36044 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247Ab0I2PSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 11:18:40 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8TFGrek023443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 29 Sep 2010 15:16:53 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTi=gL_6ueBvO7URth-rbbHyZLpwYEAMwErh1ciba@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157576>

On Wednesday 29 September 2010, Sverre Rabbelier wrote:
> On Wed, Sep 29, 2010 at 02:23, Johan Herland wrote:
> > =C2=A0Alternatively, the user can call 'git notes merge --reset' to
> > abort the notes merge.
>
> I'm torn, but I think that since we actually can here, we should call
> it 'git notes merge --abort'.

Yeah, I'm torn as well. What about providing both? Or is that bloat?

> I know that there's no 'git merge --abort', but IIRC that's for
> technical reasons only.=20

Maybe there _should_ be a 'git merge --abort' (as a synonym to 'git=20
reset --merge')?


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
