From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Patch follow-up conventions (Re: [PATCH] Makefile: don't include
 git  version file on 'make clean')
Date: Sun, 25 Jul 2010 13:49:51 -0500
Message-ID: <20100725184951.GA9636@burratino>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lynn.Lin@emc.com
X-From: git-owner@vger.kernel.org Sun Jul 25 20:51:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od6I9-0000WM-6M
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 20:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab0GYSu7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 14:50:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38926 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab0GYSu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 14:50:59 -0400
Received: by gyg10 with SMTP id 10so628710gyg.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hHEBjgLriclo2rlWtQnKGcNlwNMedRqRCSD0Ow1QNXY=;
        b=kfT5FfcZ0vB2araxGbOnAOHmNLw8KMA1uqzZTUtu4ZVxwhX2qG+TnHMF4J35OQetR7
         UpWDhSNruHc274KJVmshhDgQUCu8Xn/6OmynMOHqxqy8mLIkjcEEf0Cexmo6/TEYvwNc
         v6fM1b8O4kUodvla4j4ZtCFNzILGt0d0UOBlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Mvv7wkeHA5MevKH9ETm3le7cd7cMTgshdoKlSBLV0v8iNQNQemUIrutgx4woOyMgTX
         +7+m7qJl7KriIZ34U1AoFS0XCEeCvQPANLUYFT7fEBvKsI5MtKoWNtzu6NcZDLp4IsmX
         1VOcvLXT3/baC7FeLb09VjkRo0VKI35Aiynqo=
Received: by 10.150.52.11 with SMTP id z11mr120755ybz.312.1280083856809;
        Sun, 25 Jul 2010 11:50:56 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id m12sm4912032ybn.7.2010.07.25.11.50.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 11:50:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151777>

Hi Lynn,

Lynn Lin wrote:
> -----Original Message-----
> From: Jonathan Nieder [mailto:jrnieder@gmail.com]=20
> Sent: 2010=E5=B9=B47=E6=9C=8824=E6=97=A5 19:52
> To: Lin, Lynn
> Subject: Re: [PATCH] Makefile: don't include git version file on 'mak=
e clean'
[...]
> Thanks much ,Jonathan.
> It's my first time to try submit patch to git project:)
>=20
> Do I need to re-submit patch to add more message in commit message ?

No problem; it is always good to see people noticing things that can
be improved and fixing them. :)

In general the best thing to do (though hard) is to imagine what
would be most convenient at the receiving end and support that.
This means:

 - do not resend a whole patch when a small fixup would be easier;

 - if there has been a long discussion, once a patch is ready
   send a copy with [PATCH v2] in the subject, with a summary
   of the discussion after the "---" line and cc-ing Junio to let
   him know it is ready for application.

Another piece of advice: please convince your mailer setup to present
replies in a more useful form.  That means snipping out any irrelevant
text and somehow visually distinguishing the text you are quoting from
your reply, like I have done with "> " above.

Hope that helps,
Jonathan
