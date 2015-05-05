From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: t5570 - not cloned error
Date: Tue, 5 May 2015 18:23:41 -0400
Message-ID: <017401d08782$24d6f5b0$6e84e110$@nexbridge.com>
References: <013701d08769$a5bbab80$f1330280$@nexbridge.com> <xmqqr3qud6qm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	"'Joachim Schmitz'" <jojo@schmitz-digital.de>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 00:23:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YplFq-0002yW-9q
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 00:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965550AbbEEWXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 18:23:50 -0400
Received: from elephants.elehost.com ([216.66.27.132]:57717 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824AbbEEWXt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 18:23:49 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t45MNhsv035060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 5 May 2015 18:23:43 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <xmqqr3qud6qm.fsf@gitster.dls.corp.google.com>
X-Mailer: Microsoft Outlook 15.0
Content-language: en-ca
Thread-index: AQGTGMzZfqjkVUQ9RxorcLBPHDSlfQLCdjq/ndK9scA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268429>


On May 5, 2015 6:01 PM Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > We definitely have an issue with localhost. When forcing the DNS
resolver to
> > return 127.0.0.1, we pass 1-16 then 17 fails as I expected to happen
based
> > on my DNS futzing. Heads up that this test is not-surprisingly sensitive
to
> > DNS problems. My environment is still in a messy state where I can
reproduce
> > the original problem so it might be a useful moment for me to find a way
to
> > modify the test script to harden it. Any suggestion on that score
> > (as in where and roughly how it might be made more reliable)?
> 
> I do not think this counts as a useful "suggestion", but is this
> "resolver does not work for local as expected" case even worth
> protecting our tests against?

I see your point, but after having spent "way too much time" away from the
$DAYJOB tracking this down, I was hoping to catch the root cause earlier
next time. Perhaps adding a test step validating that localhost comes back
with a reasonable value - whatever that may be in context. I'm just not sure
what the test really needs at its heart to run properly - obviously the IP
address of the system as  visible in our DMZ is not working for the test. 
