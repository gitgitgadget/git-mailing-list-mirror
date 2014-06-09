From: =?UTF-8?Q?Pierre=2DFran=C3=A7ois_CLEMENT?= <likeyn@gmail.com>
Subject: Re: Git reset --hard with staged changes
Date: Mon, 9 Jun 2014 13:24:56 +0200
Message-ID: <CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com>
References: <CANWD=rWmzgAwTp=E_1=th0Myk-dh4m5Y9PE3=fpHeirsVVQKwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 13:25:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtxha-0006uu-A4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 13:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbaFILZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2014 07:25:19 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:48846 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbaFILZR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jun 2014 07:25:17 -0400
Received: by mail-ve0-f177.google.com with SMTP id oz11so1650089veb.22
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=J7q8gIuGUqiyY+iiGeo0UzVnh5468ORv0l0aRWU33iQ=;
        b=ewN6sCRpJnRQZN1sJvtJB91EqO3sPvLAmDu1uidh+uNF3sGpCrWdfGpv88wCMyFkBS
         wlY2FITyBHeG1UBq3UEj5y9kkAeth5ZMqKsSFN5+a18HAmqz7/6AVu5sGf+lLra+CDcO
         EeWlbD8ArkfO8cXA2G3jKjMGCkUAGOqwrJJk4oiv+e3spQXsk+UunFlYlekKYdbWXx0d
         hJiERnlKtbg80iEkWHmMCa2ET0bJk4rPt4DwCOthHw7wnD5cHbAfpA0ZYHC/IxRmw7F+
         8uNMnUsdFP4jBg63nfHzgc+pWnAu4rYH2Y0A6Qrhd/Av8xRNmfJfEyjiijmwqUUY0LRi
         HTiw==
X-Received: by 10.52.241.98 with SMTP id wh2mr21123190vdc.37.1402313116391;
 Mon, 09 Jun 2014 04:25:16 -0700 (PDT)
Received: by 10.58.182.104 with HTTP; Mon, 9 Jun 2014 04:24:56 -0700 (PDT)
In-Reply-To: <CANWD=rWmzgAwTp=E_1=th0Myk-dh4m5Y9PE3=fpHeirsVVQKwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251071>

Hi all,

Someone pointed out on the "Git for human beings" Google group
(https://groups.google.com/d/topic/git-users/27_FxIV_100/discussion)
that using git-reset's hard mode when having staged untracked files
simply deletes them from the working dir.

Since git-reset specifically doesn't touch untracked files, one could
expect having staged untracked files reset to their previous
"untracked" state rather than being deleted.

Could this be a bug or a missing feature? Or if it isn't, can someone
explain what we got wrong?
Cheers

--
Pierre-Fran=C3=A7ois CLEMENT
Application developer at Upcast Social
