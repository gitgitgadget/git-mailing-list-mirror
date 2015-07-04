From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] log --count: added test
Date: Fri, 03 Jul 2015 17:57:11 -0700
Message-ID: <xmqq8uaw4u54.fsf@gitster.dls.corp.google.com>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-4-git-send-email-lawrencesiebert@gmail.com>
	<vpqwpyh4rup.fsf@anie.imag.fr> <vpqpp491s7v.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lawrence Siebert <lawrencesiebert@gmail.com>, git@vger.kernel.org,
	remi.galan-alfonso@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jul 04 02:57:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBlf-0007wj-OV
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbbGDA5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:57:15 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36335 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbbGDA5N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:57:13 -0400
Received: by igrv9 with SMTP id v9so125015608igr.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=n10nFuE/SM8n8jPEGQDlIN9OmmyCDJxr8cTrI65+vI0=;
        b=tvfYywA9+iLiTCGfmGAD4FTaFpeNsI1rHB1w4R2qLhLiokrsQoRcmJ0+Crp4LGp+SW
         nj9cJzJnuAeydI/WTBcB9zx+gDBV5r8AK7ZYJDC0FBWFTsTgMialUTFop1jBiEcJM6Uf
         8LC8+KAmS80A1TC2gr0vF2IHgupya9xEziOTyR7pEn5cLyUMkEKGpn5QvTy1YlOT7QJx
         2rT690YdWG30PDJoUouRoHIJAHAEdMDBZgA/fVurcnkq1dNryD9X2ebkqAGoJrdj2LmE
         M7A3+EvuaGgB9u3Qsg+cKdHoBiVcOIP+ZdjJ4C5n//pyQAOEkQRqqvtgn3y3vumNZHV8
         4HpA==
X-Received: by 10.43.164.66 with SMTP id mr2mr21425781icc.85.1435971433174;
        Fri, 03 Jul 2015 17:57:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by smtp.gmail.com with ESMTPSA id pg7sm4582422igb.6.2015.07.03.17.57.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 17:57:12 -0700 (PDT)
In-Reply-To: <vpqpp491s7v.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	03 Jul 2015 11:54:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273339>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> If implementing a proper count is too hard, one option is to forbid
> --count -S and --count -G to avoid confusion.

Let's not go there.  Letting people to use "--oneline | wc -l" is
far better unless we can get --count that behaves the same as that,
only faster.
