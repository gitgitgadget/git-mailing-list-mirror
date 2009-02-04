From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 03 Feb 2009 18:09:54 -0800
Message-ID: <7v4ozb9clp.fsf@gitster.siamese.dyndns.org>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com>
 <7vocxqf2sf.fsf@gitster.siamese.dyndns.org>
 <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com>
 <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com>
 <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302>
 <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com>
 <alpine.DEB.1.00.0902031817260.6573@intel-tinevez-2-302>
 <5FE034E8-422F-4692-AD37-5633C91A4B98@silverinsanity.com>
 <alpine.DEB.1.00.0902031918520.9822@pacific.mpi-cbg.de>
 <34FE2049-0A81-4615-AE3D-46DE35A44011@silverinsanity.com>
 <7vy6wn9wdj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902032132130.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 03:11:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUXEg-00016H-7x
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 03:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbZBDCKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 21:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbZBDCKE
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 21:10:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbZBDCKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 21:10:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9AA4296214;
	Tue,  3 Feb 2009 21:10:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C9DE296213; Tue,
  3 Feb 2009 21:09:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE14A6E2-F260-11DD-B16F-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108288>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I inspected all files that git grep -p showed me, and I see that t3412 
> uses the file names, but passes explicit parameters to test_commit for 
> them.  So that is fine, too.
>
> Just as a matter of preference, I'd not downcase, but instead append a 
> ".file" in test_commit, but that's not a strong preference.  (I'd not 
> downcase, because that was done only to prevent the tag to have the same 
> name as the file, but that did not work...)

Agreed, there is no point to downcase the name.
