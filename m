From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 4/4] prune-packed: migrate to parse-options
Date: Thu, 09 Jul 2009 09:05:45 -0700
Message-ID: <4A561559.3010100@gmail.com>
References: <1247030141-11695-1-git-send-email-bebarino@gmail.com> <1247030141-11695-2-git-send-email-bebarino@gmail.com> <1247030141-11695-3-git-send-email-bebarino@gmail.com> <1247030141-11695-4-git-send-email-bebarino@gmail.com> <1247030141-11695-5-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 18:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOw8H-0002I5-11
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 18:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760251AbZGIQFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 12:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760202AbZGIQFy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 12:05:54 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:47452 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756304AbZGIQFx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 12:05:53 -0400
Received: by bwz25 with SMTP id 25so278271bwz.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=gADsP2suwv4DNBLXwRCMLpiNIY1+SEZlxEJuK1nkXns=;
        b=aPNTqzGdgxlWV5M4rQXvP9EJMkXwIHa1O2kRPLG2VTk/oDoLtKJXaO7WgGpooJphpe
         i3010m4x5t6zv49JRxgJNpPS/9zNAw8kkuwsxyDj+zdk+JxC3IutIfvHjs3AOLFFKkrq
         BxsnePZrIJtUDb0C0BuEkXAZugxHeIemWiBio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=sAinMvVmSx4BwBtgLzjpZW5DGrntF3EC1sjhxhGwY9ZXeCxPGEcI4IW0RzbK5LFutD
         3Lkc9GPflLWlUaKap8pz6mDADs33gEDJ4KB3x85LMFNBYjI82riQENqrdwF1r2xENhp5
         clRWzo+95q7YGvU8ze+DjwC2cQ2a6wMXBV+V4=
Received: by 10.204.67.67 with SMTP id q3mr894008bki.7.1247155550176;
        Thu, 09 Jul 2009 09:05:50 -0700 (PDT)
Received: from ?10.10.0.4? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id 22sm18503318fkq.23.2009.07.09.09.05.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 09:05:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <1247030141-11695-5-git-send-email-bebarino@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122986>

Stephen Boyd wrote:
> Add --dry-run and --quiet to be more consistent with the rest of git.

Add long options for dry run and quiet to be more consistent with the
rest of git.

> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
