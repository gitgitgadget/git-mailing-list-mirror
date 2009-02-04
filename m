From: Bernt Hansen <bernt@norang.ca>
Subject: Re: see commit messages on git pull
Date: Wed, 04 Feb 2009 07:57:06 -0500
Organization: Norang Consulting Inc
Message-ID: <874oza1hst.fsf@gollum.intra.norang.ca>
References: <200902041245.11242.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Wed Feb 04 13:59:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUhLK-0007iS-Ra
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 13:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757075AbZBDM5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758245AbZBDM5N
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:57:13 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:51591 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758235AbZBDM5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:57:11 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1LUhJV-000MFm-UX; Wed, 04 Feb 2009 12:57:10 +0000
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id n14Cv7Pn005181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Feb 2009 07:57:08 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n14Cv7BH019639;
	Wed, 4 Feb 2009 07:57:07 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id n14Cv6JH019637;
	Wed, 4 Feb 2009 07:57:06 -0500
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18FhZA9AZwWYc4TDziQ73xc
In-Reply-To: <200902041245.11242.thomas@koch.ro> (Thomas Koch's message of "Wed\, 4 Feb 2009 12\:45\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.95 http://www.acme.com/software/spfmilter/ with libspf2;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108359>

Thomas Koch <thomas@koch.ro> writes:

> I'd like to see the commit messages of the fetched commits, when I do
> git pull. Is that possible?
>
> It would also be fine to have sth. like git log --since-last-pull ?

git log ORIG_HEAD..

after the pull should do what you want.

-Bernt
