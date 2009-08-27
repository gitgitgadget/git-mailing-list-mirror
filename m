From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH v5 6/6] fast-import: test the new option command
Date: Thu, 27 Aug 2009 19:46:50 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0908271944540.6501@reaper.quantumfyre.co.uk>
References: <1251396736-928-1-git-send-email-srabbelier@gmail.com> <1251396736-928-2-git-send-email-srabbelier@gmail.com> <1251396736-928-3-git-send-email-srabbelier@gmail.com> <1251396736-928-4-git-send-email-srabbelier@gmail.com>
 <1251396736-928-5-git-send-email-srabbelier@gmail.com> <1251396736-928-6-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Aaron Bentley <aaron@aaronbentley.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 20:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgk4N-0001tt-VT
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbZH0Sv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbZH0SvZ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:51:25 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49547 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750862AbZH0SvZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 14:51:25 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id C2C96278876
	for <git@vger.kernel.org>; Thu, 27 Aug 2009 19:51:26 +0100 (BST)
Received: (qmail 26073 invoked by uid 103); 27 Aug 2009 19:46:50 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9744. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.026047 secs); 27 Aug 2009 18:46:50 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 27 Aug 2009 19:46:50 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <1251396736-928-6-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127197>

On Thu, 27 Aug 2009, Sverre Rabbelier wrote:

> Test three options (quiet and import/export-marks) and verify that the
> commandline options override these.
>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
>
> 	Only difference from v4 is that it is rebased and a new test to
> 	verify that 'feature git-options' is now accepted.

Don't you now need all tests of the option command to start with a 
"feature git-options" command?  (and perhaps have a test that the feature 
command is required too?)

-- 
Julian

  ---
Bubble Memory, n.:
 	A derogatory term, usually referring to a person's intelligence.
 	See also "vacuum tube".
