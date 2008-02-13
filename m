From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "git submodule status" output when "git describe" is
 not possible
Date: Tue, 12 Feb 2008 17:01:52 -0800
Message-ID: <7vprv1zn27.fsf@gitster.siamese.dyndns.org>
References: <1202861986-1159-1-git-send-email-albertito@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alberto Bertogli <albertito@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 02:04:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP62d-0001l0-5x
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 02:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765315AbYBMBDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 20:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765290AbYBMBDK
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 20:03:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862AbYBMBDI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 20:03:08 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 113732DF4;
	Tue, 12 Feb 2008 20:02:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 4805A2DEA; Tue, 12 Feb 2008 20:02:01 -0500 (EST)
In-Reply-To: <1202861986-1159-1-git-send-email-albertito@gmail.com> (Alberto
 Bertogli's message of "Tue, 12 Feb 2008 22:19:46 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73726>

Alberto Bertogli <albertito@gmail.com> writes:

> When a submodule cannot be described, doing a "git submodule status" on
> the supermodule produces unnecesary and scary output,...

I had an impression that describe got a new feature for a case
like this recently.
