From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCHv2 2/2] rev-list: documentation and test for --left/right-only
Date: Mon, 21 Feb 2011 12:37:00 -0500
Message-ID: <AANLkTikDUOkRUhXi4o-u-h8Es+sFQj=k9nx3VOOPuJ_K@mail.gmail.com>
References: <a3224c4269b26c366bb5b5df691f22f17b767f83.1298304396.git.git@drmicha.warpmail.net>
 <4D625972.4090500@drmicha.warpmail.net> <c0fce67ba8ab8e4ead233950d74048a95d3b64a6.1298304396.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 21 18:37:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrZhY-0001YQ-QT
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 18:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab1BURhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 12:37:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48922 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab1BURha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 12:37:30 -0500
Received: by iyb26 with SMTP id 26so954127iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=s724mXxU+iTzYez4VMWDXO7HB17Ai8oKHsQPX1BWZKk=;
        b=KkVa7srfl0JtEjaED4KoDSp0x576Hj9ktXjM8fuhanf3cdP/6ykm9RRfvY46xHWemz
         AMjwHvmns3TrSbqFNPwKhvOy8VwdyK7zEAcaAY4O12Q/QhpfmlMV71+vO0qY6N5fgx9M
         9Q/BMW9abT4qC8asnAZkuGcYfx7/5lMH0/LOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=pw1aNczqLyVHjADNTiIUr3L7XQwxEc6D3CcMr69GLR4+HPr4r5K/dyVp18wKJcjhjK
         56LWZXedxW+GkQi0f3ShRAsHl7y+GjXUiY1z77SCqoUkroJXNt5zLPiqc9j/dK4QHEXk
         TokloVbLU8P99ZLepSqcsRm+UorxwAjl6p7jo=
Received: by 10.231.38.2 with SMTP id z2mr1336974ibd.142.1298309850193; Mon,
 21 Feb 2011 09:37:30 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 21 Feb 2011 09:37:00 -0800 (PST)
In-Reply-To: <c0fce67ba8ab8e4ead233950d74048a95d3b64a6.1298304396.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167496>

On Mon, Feb 21, 2011 at 11:09 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> +More precisely, `--cherry-pick --right-only --ignore-merges` gives the

Nit: s/ignore-merges/no-merges/

j.
