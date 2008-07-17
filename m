From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 23:03:18 +0200
Message-ID: <200807172303.19339.jnareb@gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <20080717202609.GA32184@machine.or.cz> <57BAA376-10A4-4E3F-BB8E-37B46E8C49D3@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 23:04:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaeK-0006pR-7j
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 23:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbYGQVD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2008 17:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756791AbYGQVD2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 17:03:28 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:36654 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbYGQVD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 17:03:28 -0400
Received: by yw-out-2324.google.com with SMTP id 9so600ywe.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1UDRd3J/y0z4FrSLBSg5GxgxRbKIy9eeklWgzpJtnlE=;
        b=rgarn1MF5wVgtidqlKzh9jO5S30q2Gv1zxXm6T4VBjTV33Jc1VXsZy8/1R0RMK/2u8
         Ms6JfwRAdDO81yMIyds10vULhl2FQhlDcpaJjzlJ0+waOrUpSzw9eU9+uUhfuj7hp70q
         IHOW2flI6g18Dcycm0NfJDds/m4yERm6P5gLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ueqozu/T731Xuqo4MVHn212wbZ+FgUWZ0OpUR8iAZSKHo7cVyTF19e8rmPrGoNszkd
         009zWoyQdCns0i3EKD75dvQ+DBI1kMDwD71G87Y3x/85j+z56SBDaIYnmaYaKmZYsqx2
         arhSePCSHIGXI4pbXJJ+dV6KFgtYgCPtFSZSQ=
Received: by 10.103.202.13 with SMTP id e13mr2331317muq.3.1216328606169;
        Thu, 17 Jul 2008 14:03:26 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.254.74])
        by mx.google.com with ESMTPS id t10sm6786561muh.17.2008.07.17.14.03.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 14:03:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <57BAA376-10A4-4E3F-BB8E-37B46E8C49D3@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88921>

Dnia czwartek 17. lipca 2008 22:40, Kevin Ballard napisa=B3:
> On Jul 17, 2008, at 1:26 PM, Petr Baudis wrote:
>> On Thu, Jul 17, 2008 at 01:12:57PM -0700, Kevin Ballard wrote:

>>> There is one facet of submodules that annoys me, because it =20
>>> prevents me from using them as a replacement for svn:externals.
>>> Namely, the submodule refers to a specific repository, but not
>>> a path within that repository.  I work with svn repos that use
>>> svn:externals to peg revisions (as is appropriate) but they all
>>> refer to various paths within the other repositories, and the
>>> only way I can deal with that is to throw symlinks everywhere.
>>
>> Actually, is this a big problem? Git can track symlinks and without
>> adding support for overall partial checkouts, adding this would feel
>> like too huge a hack to me.
>>
>> Also, when converting to a different VCS, it might be sensible to =20
>> adjust
>> your modules setup a bit as well - the requirement to include only
>> particular subdirectory of a submodule sounds rather strange to me.
>=20
> The problem is right now I maintain a bunch of git-svn mirrors of =20
> internal svn repos, but the company isn't willing to switch to git. =20
> And we use subtree externals links to do things like pull in the =20
> models from one rails app into another, or pull in various =20
> subdirectories of the "support" repository.

I think the correct solution would be to make 'models' separate=20
repository... or create interim repository containing only changes
to 'models', and having 'models' as its top directory.

--=20
Jakub Narebski
Poland
