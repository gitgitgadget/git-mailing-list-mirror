From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6 (v4)] basic revision cache system, no integration or
 features
Date: Sun, 04 Oct 2009 19:15:13 -0700
Message-ID: <7vbpkmk2mm.fsf@alter.siamese.dyndns.org>
References: <op.uys3qlsjtdk399@sirnot.private>
 <op.uyuwkovjtdk399@sirnot.private> <op.u061bavktdk399@sirnot.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	"Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Andreas Ericsson" <exon@op5.se>,
	"Christian Couder" <christian@couder.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Nick Edelen" <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 04:17:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mud8u-0000nO-4g
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 04:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758267AbZJECQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 22:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758215AbZJECQV
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 22:16:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758209AbZJECQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 22:16:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52C474C8DE;
	Sun,  4 Oct 2009 22:15:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XqKnw2UalWk3mJ6ERFNkAZ3EgaQ=; b=e0tcpS
	GS1MRvwmpFmIpHYY00N7fDRvJQRHWe/J3pzMBPseFAjaj6oLo/2535eNpbk2gtal
	8Nq4Q9kd40wFJ13XEcuWWBFDM6W3Cij9pByUzvO1kR9SDy9YV97Eg1/TeU9h9Dvo
	g9EtVz0pGfpklxfXQ1p0WGomAoPKTEdmWuIWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IKWBOAbhKCnehO3KPW+r+5yTbL+y5RcG
	axXO8ZgMgisvW1Ah/MLoJbef8K9aB8ixtSPDaNCcgq3EPi7H/ixvuAtNjbNdN9pX
	2qZwHaqa4md2+MeAY9QHJSUu1zx29Fhb4hPiOtrPHOKFP2AVMdLXVkEi9o7pVTvB
	V/g0ilNLfEU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2CC14C8DB;
	Sun,  4 Oct 2009 22:15:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89FCB4C8D8; Sun,  4 Oct
 2009 22:15:14 -0400 (EDT)
In-Reply-To: <op.u061bavktdk399@sirnot.ed.ac.uk> (Nick Edelen's message of
 "Fri\, 02 Oct 2009 23\:12\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F245B8C4-B154-11DE-BF5E-92E639D9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129525>

The entire series is unusable due to whitespace breakage.
