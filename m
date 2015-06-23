From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 16:27:46 -0400
Message-ID: <005e01d0adf3$117eb880$347c2980$@nexbridge.com>
References: <1435020656.28466.8.camel@twopensource.com>		 <CAGZ79kap++fZx3X0D95d35XioRURU468xATDZpWHDOAPapAh+Q@mail.gmail.com>	 <1435089895.28466.65.camel@twopensource.com>	 <005101d0adf0$964bca10$c2e35e30$@nexbridge.com> <1435090937.28466.68.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Stefan Beller'" <sbeller@google.com>,
	"'git mailing list'" <git@vger.kernel.org>,
	"'ronnie sahlberg'" <ronniesahlberg@gmail.com>
To: "'David Turner'" <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:27:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7UnW-0007Yp-2n
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbbFWU1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:27:52 -0400
Received: from elephants.elehost.com ([216.66.27.132]:21118 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbbFWU1w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 16:27:52 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t5NKRm10087373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Jun 2015 16:27:48 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <1435090937.28466.68.camel@twopensource.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJ1O/YN/henzw5pG8BC73xzk1Dn5wJTjVJeARUmkxUCGmZtRwJ/iwWFnDFYsTA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272498>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of David Turner
> Sent: June 23, 2015 4:22 PM
> To: Randall S. Becker
> Cc: 'Stefan Beller'; 'git mailing list'; 'ronnie sahlberg'
> Subject: Re: RFC/Pull Request: Refs db backend
> 
> > Just to beg a request: LMDB is not available on some MPP architectures to
> which git has been ported. If it comes up, I beg you not to add this as a
> dependency to base git components.
> 
> My changes make `configure` check for the presence of liblmdb. The LMDB
> code is only built if liblmdb is present.  So, I think we're good.

Thanks :) You have no idea how much, in a "burnt by that in other projects" POV.

Cheers,
Randall
