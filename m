From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Whether Git supports directory level access or not?
Date: Tue, 7 Jul 2015 09:16:34 +0200
Message-ID: <559B7CD2.1040507@web.de>
References: <705bdbdc6a8195d59203bcb1f3027714@stockal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: saurabh@stockal.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 09:17:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCN7r-0004oU-1c
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 09:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbbGGHRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 03:17:00 -0400
Received: from mout.web.de ([212.227.15.14]:53624 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129AbbGGHQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 03:16:51 -0400
Received: from birne.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0M0hcE-1YtBF0413m-00uqs0; Tue, 07 Jul 2015 09:16:41
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <705bdbdc6a8195d59203bcb1f3027714@stockal.com>
X-Provags-ID: V03:K0:wKlHHQ4DHI4RWQWoNM0FA9LcFxXhbl+ZLuC1+Q1dg9e/27eFYUO
 KnBWLiGn/kWJTufIOXJK8Jri9c+lxSo9gmm+HkJ6DS+joRrkI20wEdq5dFtUj/aVl3GbpQR
 xcV7H5gWWUuZAF7K1fkOoGdOxKPDPP+nYXdw/xMu5Ct7UHFC4V3OMuUoW7dLsB9yeh6inN2
 NLc13e5PICwajMpBipVkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lyUrAufAx2k=:rbbpjb9hci64zw8/GMFYh6
 PDuc4tQZpieLHkCP2g46Ead6qU4yjLtAeU5ZG3FGsixdEvNAplOzrDSXZLa6+IqmlOTmdYySg
 2U3kz4jnmkb0mFdSIoZ9wwhzDjsttlQYtYV4VstHNRMtoLbPdomxAXY1gnyApLNL6gxCNFwJO
 g8FA/BnSKGL1ZZnZav42Rbw3FoA0+ab1mHHQREf3m9dwe0nTnlDtm4hOWnC675ju8jKYIj1nz
 Ict96fOrTIMkPFAdiTopmqLlsxb6ZPaEyI9D1S+sVLaF5wQHzGaZfG9AF3O4FlcjyhkCcyTAy
 xs332mC6h/63dtLzgN3tXRdilZWzsPJqFdLPvvAYUVG9Ins7PQaMFYTJyC5HjEidQk2IpYv5S
 RA2sXBG7n96mdNJh+jwla773bEWU+gC4+4HuEMRlxHG6rm2RgR0EyR74O+CohUcvW0c50qDig
 2rR0rC7bA5p3Xye30E+3B4GyMBa99y5qE1NRCpZPMiDNqh/YGpCutR2iWLZ2gyrMYH9IeL0Mr
 v8HBvntO3EnDL5W/SnsCge6m2mEKUOMX2vWfR9ka38CqnE66+l+03SvORqlJXzin6hk3FDi16
 Ql4yels5+C2iAPBCywHZ9cQJakRq0kzynfBL6V0T6PsJTQX5xI5W+WcWWQAzMg9s2EhwM7mhc
 lwPUgT8OABb6D0+ymEeVtwJ+eHt+JY/hH5sV6IvBUQgkcyRmhxzoCEsypyXrMQg2jxg8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273484>

On 07.07.15 08:40, saurabh@stockal.com wrote:
> Hi,
> 
> Please let me know whether Git supports directory level access or not.
> 
> For example :- Consider the structure with one repository consisting of sub directories for each product.
> main_repo:
>    dir1 dir
>    dir2 dir
>    shared-dir dir
>    private dir
> One group(user) of developers has access to dir1 and shared-dir while the other group(user) has access to dir2 and shared-resources.
> Just for context, both dir1 and dir2 require shared-dir to be checked out for building the products.
> 
> And private dir is only accessible by admin(repo owner).
> 
> Regards
> Saurabh gaur

Git is a distributed VCS.
If you do a clone, all information is available on your local machine.

Solution:
Use a different repo for private stuff, in your example you need 4 repos,
which has the advantage that each product has it's own repo.

HTH
