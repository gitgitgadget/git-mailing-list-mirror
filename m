From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #03; Fri, 8)
Date: Sun, 10 Apr 2011 02:43:56 -0700 (PDT)
Message-ID: <m3wrj230ig.fsf@localhost.localdomain>
References: <7vsjtsyp5d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>,
	"\"John 'Warthog9' Hawley\" <warthog9@kernel.org> Kevin Cernekee" 
	<cernekee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 11:44:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8rBq-00035q-KX
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 11:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab1DJJn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 05:43:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54406 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab1DJJn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 05:43:58 -0400
Received: by fxm17 with SMTP id 17so3047779fxm.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 02:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=f2RQZpY26yYfGQ11taWcZdwm8C+UUkZUHJux7Csl6eY=;
        b=VtEd/bgnagbnZFcFg/or63RpZuctWgrU10uUhC/oyn6mJUaOEHHSYeS6zJRUvU7yQt
         Z1/Wi4J8Mz453eHrQzdcLbv9/U4sNUKmLXM06opAsCdbKolXkLStP5tVwmmchfT3QcEp
         aJ+cbvctRf9LuY0vA+jXH2zqresMXZgs+F+As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=tEG5Gv9HnlSaUjcDnQ/b6JwaeohpCcU7gRJ/v35P0mapLFukqhY8zmUgxD0uzJAJor
         /knL5bMFvc88Qo16ArljBg44ldK+fGm4yqkJU58zxZiIp4YUmZHuDZ8T+3oD0XMjY1CL
         OlxfiYOY2nlX+SQVJ/r7cTrf+bDs3JHv/sQMY=
Received: by 10.223.85.196 with SMTP id p4mr1500519fal.5.1302428637008;
        Sun, 10 Apr 2011 02:43:57 -0700 (PDT)
Received: from localhost.localdomain (abwa66.neoplus.adsl.tpnet.pl [83.8.224.66])
        by mx.google.com with ESMTPS id l3sm374701fap.12.2011.04.10.02.43.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 02:43:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3A9hSCm024628;
	Sun, 10 Apr 2011 11:43:38 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3A9h45M024623;
	Sun, 10 Apr 2011 11:43:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vsjtsyp5d.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171245>

Junio C Hamano <gitster@pobox.com> writes:

> --------------------------------------------------
> [Stalled]
> 
> * jh/gitweb-localtime (2011-03-23) 1 commit
>  - gitweb: javascript ability to adjust time based on timezone

I have just send replacement patches to git mailing list,
as

  [PATCH 00/11] gitweb: Change timezone
  Message-Id: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/171212

John and Kevin, could you please review those patches if/when you have
time?  Thanks in advance.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
