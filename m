From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 13:31:37 +0100
Message-ID: <m2mxp0jk5y.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	<m2k4k5ks0b.fsf@gmail.com>
	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
	<m27hg4l8a3.fsf@gmail.com> <4CEB8774.7050504@drmicha.warpmail.net>
	<m2zkt0jsha.fsf@gmail.com> <4CEB9109.4000008@drmicha.warpmail.net>
	<m2vd3ojna1.fsf@gmail.com> <4CEBA872.2020001@drmicha.warpmail.net>
	<m2r5ecjlqd.fsf@gmail.com> <4CEBADCA.3070403@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 23 13:31:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKs2I-0004tc-37
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 13:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234Ab0KWMbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 07:31:44 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47767 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab0KWMbo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 07:31:44 -0500
Received: by wyb28 with SMTP id 28so8226723wyb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 04:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=lC2+Vppl9rwLNJ/vdf9KKcV15KuJ7y35pwKH2iW6QPM=;
        b=rM6pSbWPh0oGxIx8T8k9buaFgll6XJcZum6Ftxemz0CFAWvot92eD3KIIjVxDYGbSp
         rdIk7fJKXRIUm9wSGGMalkmAKK6KGoTj8gVZ4DrJyrkc3AVkNSR+xstbgiaohPDQP38y
         cO0MYwRCwm02PhV+cbN2/2pOwJeiRNKWIT1Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=IJYOImtDtRvZiVEWEY08oYxi36guVX49cvrM5ItA5/LCcyxu867Ho37w+SvxmMnhCL
         F4IcN+XmHrjq32QLULiez24c/KpTp1jbSFxZK0G+1ETZBbk9ecblQ5IaVh0N1aQPYmAZ
         ATk5k17RnOSIOPchrHHRyK256uJls0GFRlMYE=
Received: by 10.227.137.17 with SMTP id u17mr7490814wbt.129.1290515502015;
        Tue, 23 Nov 2010 04:31:42 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id h29sm4075864wbc.21.2010.11.23.04.31.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 04:31:40 -0800 (PST)
In-Reply-To: <4CEBADCA.3070403@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 23 Nov 2010 13:04:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161948>

Michael J Gruber <git@drmicha.warpmail.net> writes:

[...]

> etc., and all is well. My /etc/xml/catalog:

Mine is different or rather incomplete.

> <?xml version="1.0"?>
> <!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog
> V1.0//EN"
> "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd">
> <catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">
>   <delegatePublic publicIdStartString="-//OASIS//ENTITIES DocBook XML"
> catalog="file:///etc/sgml/docbook/xmlcatalog"/>
>   <delegatePublic publicIdStartString="-//OASIS//DTD DocBook XML"
> catalog="file:///etc/sgml/docbook/xmlcatalog"/>
>   <delegatePublic publicIdStartString="ISO 8879:1986"
> catalog="file:///etc/sgml/docbook/xmlcatalog"/>
>   <delegateSystem
> systemIdStartString="http://www.oasis-open.org/docbook/"
> catalog="file:///etc/sgml/docbook/xmlcatalog"/>
>   <delegateURI uriStartString="http://www.oasis-open.org/docbook/"
> catalog="file:///etc/sgml/docbook/xmlcatalog"/>

Until this point both catalog are identical, but mine stop here...

>   <rewriteSystem
> systemIdStartString="http://scrollkeeper.sourceforge.net/dtds/scrollkeeper-omf-1.0/scrollkeeper-omf.dtd"
> rewritePrefix="/usr/share/xml/scrol
> lkeeper/dtds/scrollkeeper-omf.dtd"/>
>   <rewriteURI
> uriStartString="http://scrollkeeper.sourceforge.net/dtds/scrollkeeper-omf-1.0/scrollkeeper-omf.dtd"
> rewritePrefix="/usr/share/xml/scrollkeeper/
> dtds/scrollkeeper-omf.dtd"/>
>   <rewriteSystem
> systemIdStartString="http://docbook.sourceforge.net/release/xsl/1.75.2"
> rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.75.2
> "/>
>   <rewriteURI
> uriStartString="http://docbook.sourceforge.net/release/xsl/1.75.2"
> rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.75.2"/>
>   <rewriteSystem
> systemIdStartString="http://docbook.sourceforge.net/release/xsl/current"
> rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.75.
> 2"/>
>   <rewriteURI
> uriStartString="http://docbook.sourceforge.net/release/xsl/current"
> rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.75.2"/>
> </catalog>

All this bit is missing.

I tried to reinstall xml-common, but /etc/xml/catalog is still the same
(the shortest version)...

Could you send me your catalog file ?

Thanks
-- 
Francis
