From: vishwajeet singh <dextrous85@gmail.com>
Subject: Re: GIT smart http vs GIT over ssh
Date: Tue, 31 Jul 2012 08:49:33 +0530
Message-ID: <CACbucKmEAz2BQCA28LObk_4Vk4S+-T2bAHaszNNR6=tH0mj9pg@mail.gmail.com>
References: <CACbucKmOxKLpY-iHDpX3GJ7BGsipR9hhXm8UA1hdbNdCzNMMRw@mail.gmail.com>
 <CACbucKnj5tqtAX5tJRRp+O8MA=tMD_xESsREPcAwffNS6Kvfag@mail.gmail.com> <20120731031011.GA1685@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Tue Jul 31 05:20:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw304-0007ab-Ix
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 05:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab2GaDTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 23:19:55 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59768 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab2GaDTy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 23:19:54 -0400
Received: by gglu4 with SMTP id u4so5622050ggl.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 20:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AzlW9oW4Xx+ZMHs9lpZXctSauS4lPxBYRCtn7nY9Tes=;
        b=xDnkhKkvgZJq6scCSa0I5A0yBC1o8elReePluY+9BHohPKUf1fLAwAP59Bx2t4CtoO
         TIed80XLG+XGgV3Xra9gRbxqsA23WjcihOdl+RfSEAB9J+L+IZHbmYw/imaphO9416hF
         B9dZ/J6KlgetI5amvcJPtRDx9o29FOV1PMoTkQpx87SJ49R/qFKY6aWPhT+8phdMcRtb
         +DM+xPOBESx1KmaEPBsdy14OIXs7e32Qhm0VQDYwMMLTSxBXl3q6JoRr/H+quY3AgbqK
         BgOgcVaxBOtDO0q3u3PyCpOVlz7gtJkJtjO3sANrlmM8vdlbTpy9QLToHvJoJltsye7v
         ANug==
Received: by 10.50.6.229 with SMTP id e5mr827059iga.9.1343704793663; Mon, 30
 Jul 2012 20:19:53 -0700 (PDT)
Received: by 10.64.15.70 with HTTP; Mon, 30 Jul 2012 20:19:33 -0700 (PDT)
In-Reply-To: <20120731031011.GA1685@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202628>

On Tue, Jul 31, 2012 at 8:40 AM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> On Tue, Jul 31, 2012 at 08:36:07AM +0530, vishwajeet singh wrote:
>
>> Just wanted to know the difference between smart http and ssh and in
>> what scenarios we need them
>> I am setting up a git server,  can I just do with smart http support
>> or I need to enable the ssh support to use git effectively.
>> As I understand github provides both the protocols, what's the reason
>> for supporting both protocols.
> http://git-scm.com/book/en/Git-on-the-Server-The-Protocols
> http://git-scm.com/2010/03/04/smart-http.html
>

Thanks for the links, I have already gone through those links, was
looking from implementation perspective do I really need to support
both protocols on my server or I can just do with smart http and
what's the preferred way of doing it smart http or ssh


-- 
Vishwajeet Singh
+91-9657702154 | dextrous85@gmail.com | http://bootstraptoday.com
Twitter: http://twitter.com/vishwajeets | LinkedIn:
http://www.linkedin.com/in/singhvishwajeet
