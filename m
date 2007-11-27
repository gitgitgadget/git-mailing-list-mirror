From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Tue, 27 Nov 2007 15:38:32 +0100
Message-ID: <200711271538.32457.jnareb@gmail.com>
References: <200711252248.27904.jnareb@gmail.com> <alpine.LFD.0.99999.0711261417580.9605@xanadu.home> <474C259B.1000705@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix1aT-0006t6-5D
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 15:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbXK0Oii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 09:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754667AbXK0Oii
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 09:38:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:49956 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbXK0Oih (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 09:38:37 -0500
Received: by nf-out-0910.google.com with SMTP id g13so971136nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 06:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=9OwdKNhcWHJqNK2Hjz4EHZRMmAHXW6khEUUM2EtLtlQ=;
        b=Nu/ulPoe9lBr6fDo1/MY4yqDypc4yjGcuGPY7GVCOtGUtgUzdD5FWvcLOUCyxe11I0A1KyvqmkVrP16fnhRgLIvpi+0+8BDIHMk8/rE5PyviiaJtdF+hB4zlllvMQgiLfJrvoIAClQ+zPMtrCZ3hLmvbQ7yl/ZIYlvzShNki4Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KTxWW2zrXAeR0YI+k4OzULqmKc07I7t0PV9BVBXyZyTZWkuOiXkD0Hy1lbwoi1kBfUquHxi2KpjdReVylAyfTdmGEr4CVKOSBFkC7TQLV18nR2MqYW1NhvbypJUCzXuWtbuYzpx92p6FiIjONJCgZczfv9TCiUba8P80Ovn9Oek=
Received: by 10.82.150.20 with SMTP id x20mr10725609bud.1196174315305;
        Tue, 27 Nov 2007 06:38:35 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.114])
        by mx.google.com with ESMTPS id j12sm4626529fkf.2007.11.27.06.38.32
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 06:38:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <474C259B.1000705@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66218>

Andreas Ericsson wrote:

> The "git-cmd" form of writing commands was deemed obsolete round about
> the time git.sh was rewritten in C. There's just no reason for it
> anymore.
> 
> It's unfortunate that git-sh-setup makes it equally valid for scripts to
> use either form, as we can never get rid of the dashed form when so many
> scripts in the core distribution uses it.
> 
> Ah well.

I think it would be enough to have "git" and perhaps "git-sh-setup"
in PATH, and the rest of git-cmd in EXEC_PATH != PATH.

-- 
Jakub Narebski
Poland
