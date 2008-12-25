From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Thu, 25 Dec 2008 13:44:43 +0200
Message-ID: <20081225114443.GD6115@zakalwe.fi>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 12:46:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFofD-0001x5-L3
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 12:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYLYLop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 06:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYLYLop
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 06:44:45 -0500
Received: from zakalwe.fi ([80.83.5.154]:45881 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbYLYLoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 06:44:44 -0500
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 51FA62BBEA; Thu, 25 Dec 2008 13:44:43 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7v7i5odams.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103901>

On Wed, Dec 24, 2008 at 10:36:27PM -0800, Junio C Hamano wrote:
> * The packfile machinery hopefully is more robust when dealing with
>   corrupt packs if redundant objects involved in the corruption are
>   available elsewhere.

Has anyone written a summary of how Git's redundancy operates?

* What would be the probability for a single bit flip to corrupt the 
repository?

* And what is the situation where a single bit flip can not corrupt the 
database?

* When (which commands/functions) is error detection done?

Heikki
