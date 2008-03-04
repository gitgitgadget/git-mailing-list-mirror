From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Configure test for FREAD_READS_DIRECTORIES
Date: Tue, 04 Mar 2008 03:32:57 -0800
Message-ID: <7v7igi911y.fsf@gitster.siamese.dyndns.org>
References: <200803041048.53399.michal.rokos@nextsoft.cz>
 <7vod9u92fj.fsf@gitster.siamese.dyndns.org>
 <200803041217.37027.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 12:33:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVOy-00039H-UR
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbYCDLdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 06:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755895AbYCDLdH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:33:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909AbYCDLdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 06:33:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F2152B44;
	Tue,  4 Mar 2008 06:33:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 058AC2AFD; Tue,  4 Mar 2008 06:32:59 -0500 (EST)
In-Reply-To: <200803041217.37027.michal.rokos@nextsoft.cz> (Michal Rokos's
 message of "Tue, 4 Mar 2008 12:17:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76068>

Michal Rokos <michal.rokos@nextsoft.cz> writes:

>> On how many different platforms was this configure check tested on?
>
> Test works on Linux (no FREAD_READS_DIRECTORIES) and HPUXes 
> (FREAD_READS_DIRECTORIES): HP-UX B.11.23 ia64 (Itanium) and HP-UX B.11.11 
> 9000/800 (PaRisc)
>
> Do you want me to resend with "."?

Probably resending with "." and asking the list audiences for help in
testing would help you gather success reports on different platforms.
