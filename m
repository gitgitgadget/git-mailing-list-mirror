From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] Support ent:relative_path
Date: Fri, 4 May 2007 22:26:13 +0200
Message-ID: <20070504202613.GC4033@steel.home>
References: <463AE404.9060906@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 22:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk4M6-00067F-FU
	for gcvg-git@gmane.org; Fri, 04 May 2007 22:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031533AbXEDU0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 16:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031535AbXEDU0P
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 16:26:15 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:49726 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031533AbXEDU0P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 16:26:15 -0400
Received: from tigra.home ([195.4.202.37] [195.4.202.37])
	by post.webmailer.de (mrclete mo41) (RZmta 5.8)
	with ESMTP id B04b38j44JDu9V ; Fri, 4 May 2007 22:26:13 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3F370277BD;
	Fri,  4 May 2007 22:26:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1DBC9D171; Fri,  4 May 2007 22:26:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <463AE404.9060906@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46212>

Dana How, Fri, May 04, 2007 09:43:00 +0200:
> +	if (!strcmp(var, "core.relativepaths")) {
> +		assume_relative_paths = git_config_bool(var, value);
> +		return 0;
> +	}

Still don't like it. What good is a syntax you cannot depend upon?
