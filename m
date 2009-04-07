From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [PATCH RFC 6/6] send-email: Remove horrible mix of tabs and spaces
Date: Wed, 8 Apr 2009 01:33:01 +0200
Message-ID: <BEB50B8F-2E86-428E-9E9B-C48FC24A2BA5@dbservice.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com> <1239139522-24118-2-git-send-email-mfwitten@gmail.com> <1239139522-24118-3-git-send-email-mfwitten@gmail.com> <1239139522-24118-4-git-send-email-mfwitten@gmail.com> <1239139522-24118-5-git-send-email-mfwitten@gmail.com> <1239139522-24118-6-git-send-email-mfwitten@gmail.com> <9b18b3110904071435p320e5d1dh16061d04a3a8ab57@mail.gmail.com> <b4087cc50904071442ka298564x52112c1eac9ac284@mail.gmail.com> <20090407220048.GB18144@coredump.intra.peff.net> <49DBCF5D.6070404@op5.se>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Michael Witten <mfwitten@gmail.com>,
	demerphq <demerphq@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <exon@op5.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 01:35:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrKp5-0004wV-UL
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 01:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbZDGXdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 19:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754841AbZDGXdg
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 19:33:36 -0400
Received: from office.neopsis.com ([78.46.209.98]:54239 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbZDGXdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 19:33:35 -0400
Received: from [192.168.0.130] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Wed, 8 Apr 2009 01:33:27 +0200
In-Reply-To: <49DBCF5D.6070404@op5.se>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116011>


On Apr 8, 2009, at 12:10 AM, Andreas Ericsson wrote:
> 3. Make it capable of sending email directly from commits rather than
>  than having to generate them as files first. For bonus-points, use

This is already possible:
   git send-email [options] <file|directory|rev-list options>
You can pass it a rev-list and it will generate the patches on its own.

>  git sequencer or some other "git rebase -i"-esque mangling thing
>  first, with capabilities of adding a cover-letter for patch-series.


tom
