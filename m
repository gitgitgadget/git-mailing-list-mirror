From: Bernt Hansen <bernt@norang.ca>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 05 Oct 2007 09:07:08 -0400
Organization: Norang Consulting Inc
Message-ID: <87r6k9r9qb.fsf@gollum.intra.norang.ca>
References: <20071005082026.GE19879@artemis.corp>
	<20071005085522.32EFF1E16E@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 15:07:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idmtp-0001xo-7x
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 15:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbXJENHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 09:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXJENHQ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 09:07:16 -0400
Received: from outbound.mailhop.org ([63.208.196.171]:1290 "EHLO
	outbound.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbXJENHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 09:07:15 -0400
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([74.119.210.211] helo=mail.norang.ca)
	by outbound.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1Idmtd-000Edi-Ft; Fri, 05 Oct 2007 09:07:13 -0400
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 74.119.210.211
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+K6NCiJNRCYuGJP+n7gbo9
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id l95D78rZ023418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 5 Oct 2007 09:07:10 -0400
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.1/8.14.1/Debian-9) with ESMTP id l95D78Qa010996;
	Fri, 5 Oct 2007 09:07:08 -0400
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.1/8.14.1/Submit) id l95D78iA010995;
	Fri, 5 Oct 2007 09:07:08 -0400
In-Reply-To: <20071005085522.32EFF1E16E@madism.org> (Pierre Habouzit's message of "Fri\, 5 Oct 2007 10\:11\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60080>

This fixes it for me.  Thanks!!

Bernt
