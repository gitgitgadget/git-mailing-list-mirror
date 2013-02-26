From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATH/RFC] Revert "compat: add strtok_r()"
Date: Tue, 26 Feb 2013 17:48:00 +0100
Message-ID: <CABPQNSZgn5dfy2j7dL6GEVYc5Z4HbzFrMmoU-cStv60uiUGYog@mail.gmail.com>
References: <1359714786-1912-1-git-send-email-kusmabite@gmail.com>
 <20130201204927.GG12368@google.com> <7v7glw288j.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 17:49:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UANiE-0004mQ-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 17:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759625Ab3BZQsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 11:48:41 -0500
Received: from mail-ia0-f177.google.com ([209.85.210.177]:51172 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759552Ab3BZQsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 11:48:41 -0500
Received: by mail-ia0-f177.google.com with SMTP id o25so3530642iad.8
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZLExcpwtiX4BTExpR8juvLt1pkkHBEFKC/Nk/gXrpP0=;
        b=g1uaMa9OqfBZH3/kw3e00OVCo8s4PNidHF0FjmImxT00jwfcpXCiZP6rzFtzqtSbmd
         x09mufkDGfvhW6EYea6Cdf2fgCxeixHYguWQf7hH2LPDL+Qauj8rgGZLuEsDIt1sy4pY
         FkSxz4QV196UNkguNqSXqiCfYoks3XrwhSDKxeF55WiTGzOkzJA3o+EMurnwTvfrCtuZ
         DCgcafRIu1s8ybo2H2Iv3FJLJiCHw+LDMoNn2Vyqf0cahjFiKg+ckssEYpjv7qWMKaTf
         M14rq7v8ZfvbP7oWg9qqkxsUsYp3y10rf7Xcj2IB64ttVzbWbAck9UBg+DUpqUjLpyar
         FgUw==
X-Received: by 10.50.7.242 with SMTP id m18mr5819242iga.53.1361897320556; Tue,
 26 Feb 2013 08:48:40 -0800 (PST)
Received: by 10.64.48.193 with HTTP; Tue, 26 Feb 2013 08:48:00 -0800 (PST)
In-Reply-To: <7v7glw288j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217146>

On Mon, Feb 25, 2013 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Care to tie the loose end on this one, with a sign-off?

Yes, I'll get right to it, sorry for the delay!
