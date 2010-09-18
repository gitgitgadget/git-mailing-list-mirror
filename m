From: Andreas Ericsson <ae@op5.se>
Subject: Re: Libcurl
Date: Sat, 18 Sep 2010 10:41:15 +0200
Message-ID: <4C947B2B.308@op5.se>
References: <4C943BF9.9040104@ihug.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jess McKenzie - JZM Web Development <jessmckenzie@ihug.co.nz>
X-From: git-owner@vger.kernel.org Sat Sep 18 10:41:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwszE-00015u-87
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 10:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275Ab0IRIlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 04:41:19 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34849 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751969Ab0IRIlR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 04:41:17 -0400
Received: from source ([209.85.215.175]) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTJR7LPPkMF75Ij+6xm6ICgOd/0TqO1ru@postini.com; Sat, 18 Sep 2010 01:41:17 PDT
Received: by eyb7 with SMTP id 7so1333383eyb.20
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 01:41:16 -0700 (PDT)
Received: by 10.213.113.209 with SMTP id b17mr632452ebq.39.1284799275913;
        Sat, 18 Sep 2010 01:41:15 -0700 (PDT)
Received: from clix.int.op5.se (fw1-sth-pio.op5.com [109.228.142.130])
        by mx.google.com with ESMTPS id v59sm7210261eeh.4.2010.09.18.01.41.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Sep 2010 01:41:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6 ThunderGit/0.1a
In-Reply-To: <4C943BF9.9040104@ihug.co.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156438>

On 09/18/2010 06:11 AM, Jess McKenzie - JZM Web Development wrote:
> How do I compile git with libcurl

You install curl and its development package before you build git.
If you're on windows, I think it's bundled. Otherwise

  yum install libcurl-devel

should do the trick if you're on any kind of redhat derived system.
OTOH, you'd probably be better off just installing the precompiled
packages on any sort of unixy system.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
