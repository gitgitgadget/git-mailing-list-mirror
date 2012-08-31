From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] test: set the realpath of CWD as TRASH_DIRECTORY
Date: Fri, 31 Aug 2012 09:49:22 +0200
Message-ID: <50406C82.2070005@alum.mit.edu>
References: <5030F0BF.2090500@alum.mit.edu> <f58965733e604a9fe6ed72384d0307062403b478.1346043214.git.worldhello.net@gmail.com> <7vk3wktiph.fsf@alter.siamese.dyndns.org> <503D973D.8040402@alum.mit.edu> <7vmx1exmde.fsf@alter.siamese.dyndns.org> <503DCFAE.6060307@alum.mit.edu> <7vy5kxwtdo.fsf@alter.siamese.dyndns.org> <503EEDF3.2080202@alum.mit.edu> <7vzk5dt0g5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Lea Wiemann <lewiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 09:56:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7M5j-0000Dx-KI
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 09:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab2HaH42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 03:56:28 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:45790 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750765Ab2HaH41 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2012 03:56:27 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Aug 2012 03:56:27 EDT
X-AuditID: 1207440d-b7f236d000000943-be-50406c855576
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 61.49.02371.58C60405; Fri, 31 Aug 2012 03:49:25 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7V7nMwv004037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 31 Aug 2012 03:49:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vzk5dt0g5.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqNua4xBgcOa9vEXXlW4mi4beK8wW
	R09ZWKx/d5XZgcVj56y77B4XLyl7fN4kF8AcxW2TlFhSFpyZnqdvl8Cd8ftFfMFL9oovM9Qb
	GDezdTFyckgImEhc+raDFcIWk7hwbz1QnItDSOAyo8TB/s/MEM5xJom9W7aDVfEKaEusnz0H
	rJtFQFWiceNhdhCbTUBXYlFPMxOILSoQIrHm2xRGiHpBiZMzn7CA2CICahIT2w6B2cwCJRLf
	304Fmyks4CHx98A6JohlbcwS1/a3gS3gFDCTeHGkjRmiQUfiXd8DKFteYvvbOcwTGAVmIdkx
	C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKEhDDvDsb/62QO
	MQpwMCrx8F5ZZx8gxJpYVlyZe4hRkoNJSZS3P8shQIgvKT+lMiOxOCO+qDQntfgQowQHs5II
	L5sVUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMFrkw3UKFiUmp5a
	kZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1PhiYKyCpHiA9jqCtPMWFyTmAkUhWk8x6nJ8
	fnryLqMQS15+XqqUOG8XyOECIEUZpXlwK2AJ6xWjONDHwrzTQUbxAJMd3KRXQEuYgJbIadiD
	LClJREhJNTBqrU8QiHfLLtf2mzgxbu4uxq2nGrb/XL1tos1+0fiXV/m9rDliLHeWf2YQXLDy
	vlxd6Z7Gz4q3GmMYtx5hFl2RFiLZ+ndmdvted547a2ITjkw+tPztpsMnHf79dQ1o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204581>

On 08/30/2012 07:26 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> By the way, is the use of realpath(3) permissible in git code?
>> GIT_CEILING_DIRECTORIES handling could be fixed relatively easily by
>> using this function to canonicalize pathnames before comparison.
> 
> As long as we can add a compat/realpath.c (perhaps lift one from
> glibc before they went GPLv3) for platforms that matter, I do not
> see it as a huge problem.  How close is abspath.c::real_path() to
> what you need?

Cool, I didn't know about that function.  It's approximately what is
needed, except that it dies if fed an invalid path (unacceptable when
processing GIT_CEILING_DIRECTORIES) and it's buggy (try "test-path-utils
real_path ''" or "test-path-utils real_path '/foo'").  However, I'm
working on fixing it and splitting off a variant that returns NULL on
errors.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
