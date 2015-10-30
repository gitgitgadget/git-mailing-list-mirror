From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Fri, 30 Oct 2015 18:26:38 -0400
Message-ID: <015b01d11362$0b8c1e70$22a45b50$@com>
References: <CA+izobsBmYHHepYka795K2VnVLYBmN2tFqEyzSweMoS9gvuRVw@mail.gmail.com> <1446243500-21580-1-git-send-email-apahlevan@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Atousa Pahlevan Duprat'" <apahlevan@ieee.org>
To: "'Atousa Pahlevan Duprat'" <atousa.p@gmail.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:27:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsI8Q-00037f-QP
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 23:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759827AbbJ3W0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 18:26:55 -0400
Received: from elephants.elehost.com ([216.66.27.132]:10669 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759598AbbJ3W0y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 18:26:54 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gojira (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t9UMQpka072417
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Oct 2015 18:26:52 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <1446243500-21580-1-git-send-email-apahlevan@ieee.org>
X-Mailer: Microsoft Office Outlook 12.0
Content-language: en-ca
Thread-index: AdETYPw77k/rIM5KSEmtYZnouNJxrwAANCeg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280553>

On October-30-15 6:18 PM, Atousa Pahlevan Duprat wrote:
>Some implementations of SHA_Updates have inherent limits on the max chunk
size. >SHA1_MAX_BLOCK_SIZE can be defined to set the max chunk size
supported, if >required.  This is enabled for OSX CommonCrypto library and
set to 1GiB.
>---
> <snip>

Didn't we have this same issue with NonStop port about a year ago and
decided to provision this through the configure script?

Cheers,
Randall
