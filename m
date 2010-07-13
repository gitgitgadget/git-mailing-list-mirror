From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Use dev_t for device id (st_dev) from stat in 
	setup_git_directory_gently()
Date: Tue, 13 Jul 2010 09:26:30 +0000
Message-ID: <AANLkTiku82MylNMUX6P8be3xSLVg8g8aYsNWodaOM6LQ@mail.gmail.com>
References: <1279011720-21424-1-git-send-email-harinath@hurrynot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Raja R Harinath <harinath@hurrynot.org>
X-From: git-owner@vger.kernel.org Tue Jul 13 11:27:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYblQ-000234-LO
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 11:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711Ab0GMJ0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 05:26:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54483 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab0GMJ0c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 05:26:32 -0400
Received: by iwn7 with SMTP id 7so5647186iwn.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=1riAJAHeirbH1CetgAtuDBuyfKkoPRheTtzjMjMQ/Pw=;
        b=keyoKwGucSRQ6HySnxzwwVH6vT2JV1MGB1Kw0it6RCbmGXswlqSkHcJaLYH9pmYDsL
         Gv5/C/VHXqglH5R4X5NWE/digGCAby2u3a2cSEncd7eVjlNKiafTuhKDCtC9q08mcbfI
         BqoBihps5KXutYxTOr9SpaD+Rwu3a6RmFnR6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tlMCLLARD69BYvdGcV4ZX6rxqLtYD5uTShMgxvVRKqk9N0RfpIDnOiZrb9LpZXGTAl
         Y5P5PQPEBtovNmm0SjzVbMjjYMxNGi/ZLwcknL7e4FT98krWmLbwXW0oKOmydmtbfPsz
         wxEBMlYIWl1OJLaOcxq5zp3oM9vE9/ByZ/DD4=
Received: by 10.231.174.136 with SMTP id t8mr16047070ibz.158.1279013190278; 
	Tue, 13 Jul 2010 02:26:30 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 13 Jul 2010 02:26:30 -0700 (PDT)
In-Reply-To: <1279011720-21424-1-git-send-email-harinath@hurrynot.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150892>

On Tue, Jul 13, 2010 at 09:02, Raja R Harinath <harinath@hurrynot.org> wrote:
> The original declaration was int, which seems to cause trouble on my
> machine.

What OS/architecture is your machine running?
