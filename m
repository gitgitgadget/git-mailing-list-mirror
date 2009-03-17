From: Carlos Rica <jasampler@gmail.com>
Subject: Re: [PATCH] Tests: use test_cmp instead of diff where possible
Date: Tue, 17 Mar 2009 14:02:37 +0100
Message-ID: <1b46aba20903170602j79735631uf20e0a729e69c4b@mail.gmail.com>
References: <1237124036-1348-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 14:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjYxm-0000fY-ES
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 14:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbZCQNCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 09:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbZCQNCl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 09:02:41 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:55911 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbZCQNCl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 09:02:41 -0400
Received: by bwz17 with SMTP id 17so53306bwz.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=riLcexF4+ay46bKmv8NyDzIFuP/H4H2Q/rbk0nsQiWQ=;
        b=cyYOB93LcyHB5gUN5l1ErQeKDp1tl7YM70ovMZmrlRogdeZAUGDoyQX/edlKjgzr+v
         HaWhBbff29YZN/0wpi8D6tJROPLruZymcfd9qK+zn7NqxvSPlJ5oZaCwnZBmc0c3ATvx
         jmdvbn1EajG88G+9d/v8Gex3DOFVvBg9TxOzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nVsHayZZAsT16YiervsOskFFQ2FZHR9e8gpTnOPSnqsUyTfCROuMm6pB1fUA4soJ7N
         M9XWz//3TvudBkd2iFmPRJr0XvZu0NoecQf0ouDIKnhb1zhJSVl+Eg7glQu0qH26xFx3
         6wzSuxgLlO1BmAcaXbNoP6G7OnwjO0dJaeD4w=
Received: by 10.223.118.6 with SMTP id t6mr4331149faq.79.1237294957857; Tue, 
	17 Mar 2009 06:02:37 -0700 (PDT)
In-Reply-To: <1237124036-1348-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113467>

On Sun, Mar 15, 2009 at 2:33 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> Several old tests were written before test_cmp was introduced, convert
> these to test_cmp.

What about the current other calls to cmp? I don't know if they should
be changed too. Are they just the subject of another future change or
have a different purpose? I recently used test_cmp in a test full of
cmp calls (t1300-repo-config.sh).
