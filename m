From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: compiling git on debian
Date: Tue, 16 Jun 2009 16:49:26 +0530
Message-ID: <f46c52560906160419g25f43ed0g253aff35031faf2d@mail.gmail.com>
References: <f46c52560906160406t910f5f3v4040525531ad78c4@mail.gmail.com>
	 <alpine.DEB.2.00.0906161309370.14053@yvahk2.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 13:19:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGWhd-00032a-Pb
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 13:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272AbZFPLTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 07:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbZFPLTZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 07:19:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:54477 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238AbZFPLTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 07:19:24 -0400
Received: by wa-out-1112.google.com with SMTP id j5so898725wah.21
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=ezlgU99uaYCkl8RaiibKm/R4/DZQD+7Nrj82ktwBXjE=;
        b=KXYc+/cifraIXSbhfPYobRplHNKONAFVQjHKE2Q3QhPEZmQHZ+rJYaFO2AU9pPhTn6
         WDwEa++ZapzbJlJ6rS4+ldPsF6NBmG4LzOzw3Sh2Oq7QKPQ315QD0SJzJwC6D/5RZ7n9
         BneIym2dCdiKYV/L2MH01dDiwVMx1CArYsOyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=JSRnZC35T/8H23Iwu41ct+0GXz9U+jb4EqEdX0lyJxnALqe+8AlXqHjWnoBzl9m2Vv
         lADCzIhIs0u3YtMp1qm/ZgZ2TPHdMP8SlyG220eUWF9yRNV1/T74CRDFw0Vqt73+qQUf
         LSi0vhLbBpfGc8T7PWh8ttpIO8D2NXbPYqhNg=
Received: by 10.114.88.19 with SMTP id l19mr13329993wab.208.1245151166883; 
	Tue, 16 Jun 2009 04:19:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0906161309370.14053@yvahk2.pbagnpgbe.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121673>

On Tue, Jun 16, 2009 at 4:42 PM, Daniel Stenberg<daniel@haxx.se> wrote:
> On Tue, 16 Jun 2009, Rustom Mody wrote:
>
>> Im trying to compile git on debian etch and get a problem with curl-config
>> not found. I gather curl-config is in a number of debian dev packages.
>
>> Can someone tell me which which package?
>
> $ dpkg -S /usr/bin/curl-config
> libcurl4-openssl-dev: /usr/bin/curl-config
>
> (or you can opt to get the gnutls version if you prefer that)

Ja Thats what I observed that libcurl-openssl-dev, libcurl-gnutls-dev
both seem to supply curl-config. So are both interchangeable?
