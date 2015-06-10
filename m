From: Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH v2 17/19] pull --rebase: exit early when the working
 directory is dirty
Date: Wed, 10 Jun 2015 07:53:40 +0200
Message-ID: <20150610055340.GA15753@vps892.directvps.nl>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
 <1433314143-4478-18-git-send-email-pyokagan@gmail.com>
 <20150603102716.GA29730@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 07:53:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2YxS-00015p-5p
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 07:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbbFJFxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 01:53:46 -0400
Received: from ikke.info ([178.21.113.177]:53863 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932985AbbFJFxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 01:53:42 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id F2B644400A4; Wed, 10 Jun 2015 07:53:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150603102716.GA29730@vps892.directvps.nl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271255>

On Wed, Jun 03, 2015 at 12:27:16PM +0200, Kevin Daudt wrote:
> On Wed, Jun 03, 2015 at 02:49:01PM +0800, Paul Tan wrote:
> > Re-implement the behavior introduced by f9189cf (pull --rebase: exit
> > early when the working directory is dirty, 2008-05-21).
> 
> When the option rebase.autoStash is set, it should not be necessary to
> die in this case. See also this[1] patch I'm working on.
> 

Sorry, didn't notice it was you who reviewed my patch.
