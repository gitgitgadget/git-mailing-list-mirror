From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Simplest update to bash completions to prevent
	unbounded variable errors
Date: Tue, 13 Jan 2009 07:33:08 -0800
Message-ID: <20090113153308.GP10179@spearce.org>
References: <496C1F5F.9020604@tedpavlic.com> <20090113152047.GO10179@spearce.org> <496CB3B0.7010605@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 16:34:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMlHm-0007GR-Gw
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 16:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbZAMPdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 10:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZAMPdK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 10:33:10 -0500
Received: from george.spearce.org ([209.20.77.23]:38743 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbZAMPdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 10:33:09 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 81E5438210; Tue, 13 Jan 2009 15:33:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496CB3B0.7010605@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105502>

Ted Pavlic <ted@tedpavlic.com> wrote:
>>> Another try at fixing bash completions in "set -u" environments.
>> I agree with Junio; setting -u in your interactive shell is as bad
>> as export CDPATH.  Its crazy.
>
> This whole series of patches was inspired by a group of workstations at  
> a university that set -u by default for all users.

The changes look less nasty than I originally thought.  If you can
split the history out and justify the changes in the corresponding
commit messages, I think I can ACK the series.

-- 
Shawn.
