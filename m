From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] git-cvsimport: support local timezone
Date: Fri, 12 Oct 2012 00:43:53 +0200
Message-ID: <50774BA9.40609@alum.mit.edu>
References: <1349988497-6158-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 00:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMRU8-0001dD-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 00:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086Ab2JKWn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 18:43:58 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:62456 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756813Ab2JKWn5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 18:43:57 -0400
X-AuditID: 1207440d-b7f236d000000943-fe-50774bacc300
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 03.B0.02371.CAB47705; Thu, 11 Oct 2012 18:43:56 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9BMhsuF013028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Oct 2012 18:43:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <1349988497-6158-1-git-send-email-chris@rorvick.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLvGuzzAYPsDLYudc/exWnRd6WZy
	YPLYfZrV4/MmuQCmKG6bpMSSsuDM9Dx9uwTujHs9D9kKNrJWvF1W3MC4kqWLkZNDQsBE4sL6
	g0wQtpjEhXvr2boYuTiEBC4zSmw79p0VwjnOJPF112w2kCpeAU2JjuO/mEFsFgFViU8fDjOC
	2GwCuhKLeprBJokKhEm8+3WUFaJeUOLkzCdg20SA6u81XGXvYuTgYBYQl+j/BxYWFrCSmLoC
	ZDwH0C4HiRU9KiBhTgFHicX3v4FtYhbQkXjX9wDKlpfY/nYO8wRGgVlIFsxCUjYLSdkCRuZV
	jHKJOaW5urmJmTnFqcm6xcmJeXmpRbpGermZJXqpKaWbGCEhyruD8f86mUOMAhyMSjy8TG/L
	AoRYE8uKK3MPMUpyMCmJ8r5wLw8Q4kvKT6nMSCzOiC8qzUktPsQowcGsJML7ShMox5uSWFmV
	WpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4A32AmoULEpNT61Iy8wpQUgzcXCC
	DOeSEilOzUtJLUosLcmIB0VpfDEwTkFSPEB7lUDaeYsLEnOBohCtpxh1OT42znvIKMSSl5+X
	KiXOqwNSJABSlFGaB7cClpBeMYoDfSzMWwNSxQNMZnCTXgEtYQJaIjOpBGRJSSJCSqqB0aDV
	9Q/jQXvhtZ4amww/b23UTeU77jHVYf4j6xlvsndv7dSXLDi2pJ+L5WaVq+3d/4X+Xb9XKu/n
	c25aZ7dkSeunDt606jCOFYtO7F8iujvDc8rzIF3O406p72+muoY63pv/OkY+Y1av 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207518>

On 10/11/2012 10:48 PM, Chris Rorvick wrote:
> CVS patches are unconditionally imported with a UTC timezone.  Allow
> the local timezone by adding -l to the command line or specifying
> cvsimport.l in the config.
> 
> This could be made the default behavior, as setting TZ=UTC in the
> environment before doing the import is equivalent to the current
> behavior.  But since a new default may be an unwelcome surprise to
> some, make this new behavior available os an option.

According to rcsfile(7), all times in RCS/CVS files are recorded in UTC.
 So why do you need this feature?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
