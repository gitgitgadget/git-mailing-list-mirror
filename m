From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Unstaging a partly staged entry didn't update
	file_states correctly
Date: Sat, 23 Jan 2010 14:43:53 -0800
Message-ID: <20100123224353.GE12679@spearce.org>
References: <4B1D672F.3030805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYoiC-000116-RT
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab0AWWoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413Ab0AWWn5
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:43:57 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:51852 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab0AWWn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:43:56 -0500
Received: by iwn16 with SMTP id 16so1116632iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 14:43:55 -0800 (PST)
Received: by 10.231.145.20 with SMTP id b20mr1270528ibv.78.1264286635761;
        Sat, 23 Jan 2010 14:43:55 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm3095805iwn.10.2010.01.23.14.43.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 14:43:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B1D672F.3030805@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137873>

Jens Lehmann <Jens.Lehmann@web.de> wrote:
> When unstaging a partly staged file or submodule, the file_states list
> was not updated properly (unless unstaged linewise). Its index_info part
> did not contain the former head_info as it should have but kept its old
> value.
> 
> This seems not to have had any bad effects but diminishes the value of
> the file_states list for future enhancements.
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

Thanks, applied.

-- 
Shawn.
