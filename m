From: Bernt Hansen <bernt@alumni.uwaterloo.ca>
Subject: Re: [PATCH 1/2] gitweb: Style all tables using CSS
Date: Mon, 19 Nov 2007 09:27:10 -0500
Message-ID: <87d4u671kx.fsf@gollum.intra.norang.ca>
References: <1195478172-17226-1-git-send-email-jnareb@gmail.com>
	<1195478172-17226-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 16:31:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu8ag-0005Zf-Ut
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 16:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbXKSPa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 10:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753955AbXKSPa5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 10:30:57 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55878 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbXKSPa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 10:30:56 -0500
X-Greylist: delayed 3822 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2007 10:30:56 EST
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1Iu7aj-000BKy-8r; Mon, 19 Nov 2007 14:27:13 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/ZHD5Ku6Tg4ZwmrzGwzELX
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id lAJERAKD016206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 19 Nov 2007 09:27:11 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.2/8.14.2/Debian-1) with ESMTP id lAJERAg2005967;
	Mon, 19 Nov 2007 09:27:10 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.2/8.14.2/Submit) id lAJERAb0005965;
	Mon, 19 Nov 2007 09:27:10 -0500
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65455>

Jakub Narebski <jnareb@gmail.com> writes:

> -	print "<table cellspacing=\"0\">\n" .
> +	print "<table class=\"projects_list\">\n" .

Should this class be "project_list" instead?  I don't see a definition
of "projects_list" (plural) anywhere.

Bernt
