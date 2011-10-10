From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5/RFC 1/6] Documentation: Preparation for gitweb manpages
Date: Mon, 10 Oct 2011 16:10:31 -0700
Message-ID: <7v62jwjvdk.fsf@alter.siamese.dyndns.org>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
 <1318098723-12813-2-git-send-email-jnareb@gmail.com>
 <7vwrcck1jm.fsf@alter.siamese.dyndns.org>
 <201110102352.25456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 01:10:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDOzX-0007I4-C8
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 01:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491Ab1JJXKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 19:10:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab1JJXKe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 19:10:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A56704AA3;
	Mon, 10 Oct 2011 19:10:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TBbvafFjgC5wSzF+l+qU0pVCaI4=; b=QeNUW8
	/sqfhlb576u1slYhQKE9I9jmvZf5WYdMWcVBw4ONMabtuCsobKboSCY+qmgeo0m3
	CTtPic0GuDTToWtexv9htFrAfwgR/NGRX2krveU31zngaV5CXTEj1E6Nn/WVsNU9
	NlWf8ONvGNHv2b5UoVf8PJ0EWS6GOKH3vAgLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uXBf+VRawoY4ojFIkSqyrBumzBw/FEyx
	PzotCYFN6hrLy898LbMMFOTvl8gnvGMglBTarswTNy9TH00cS7FesS+BISzRY3Po
	/ciqEYCp3c1FzcgSYS+9NveedIqKav+K4OVcB4TKUWr4hMuPFsSoDyVeYv5TNFg0
	TRbR3OX3Y3w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CA6B4AA2;
	Mon, 10 Oct 2011 19:10:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 334ED4AA1; Mon, 10 Oct 2011
 19:10:33 -0400 (EDT)
In-Reply-To: <201110102352.25456.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon, 10 Oct 2011 23:52:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E0B47A2-F395-11E0-94B4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183266>

I probably do not have time to look into this, but just FYI my trial merge
to 'pu' of this topic is failing like this:

asciidoc: ERROR: gitweb.conf.txt: line 484: illegal style name: Default: ()
asciidoc: ERROR: gitweb.conf.txt: line 494: illegal style name: Default: 300
