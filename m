From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 3/3] completion: add new zsh completion
Date: Mon, 15 Oct 2012 08:38:03 +0200
Message-ID: <CAMP44s1XG43c0MDCa2mSA=R5YMF=jNSGVdv=UrHKsHmrmRCXMw@mail.gmail.com>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
	<1350229971-9343-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER Gabor <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:38:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeJc-0000Zc-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab2JOGiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 02:38:05 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60496 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab2JOGiE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:38:04 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so4586079obb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8+5dZOihK0mOwdL6M2Tdw4h/EF0IF4gb5nbPK/wugjg=;
        b=aaGSAXAHVdGt+JNFfeK2olGWGrY8l05hqjy5TI5dgN6zM3NDRNdjY35SnqJEGvMZaK
         q09xk+gh/9+8Q9tezy4+ZKyTq/+iaHSwNAHh/vXiZwRJa1VYBHQbXQDEfq30FYYinUpx
         /B0IOBTej0tkYWlvir2pC0ZJxq/96ScOuh9uliRRQ8SviH45ZQniBcVdmOiZI42YHNao
         Ar8wxCoNJmJ0Zvb4rr3R9xbdTm+5u2bHCJYtnTaNpVeDescYv0s0V7st7uslXG4ZIE53
         Vqwbch8OMsSZIN6vDS/ZiBPlmJ1bQxzTWBB8smhbLS36YtPGiEDx2vtJqSPc/GI56rqo
         AAUw==
Received: by 10.60.170.179 with SMTP id an19mr3910777oec.46.1350283083369;
 Sun, 14 Oct 2012 23:38:03 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Sun, 14 Oct 2012 23:38:03 -0700 (PDT)
In-Reply-To: <1350229971-9343-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207724>

On Sun, Oct 14, 2012 at 5:52 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> +__gitcompadd ()
> +{
> +       compadd -Q -S "$4" -P "$2" -p "${(M)cur#*[=:]}" -- ${=1} && _ret=0

I just found a bug, should be:

compadd -Q -S "$4" -P "${(M)cur#*[=:]}" -p "$2" -- ${=1} && _ret=0

-- 
Felipe Contreras
