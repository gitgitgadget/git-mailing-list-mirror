From: "Jacobs, Todd" <todd.jacobs@cognex.com>
Subject: RE: Pull and fetch don't honor `--progress` flag
Date: Wed, 16 Oct 2013 17:27:09 -0400
Message-ID: <48AC4CE6F0887542B2A5E28E4E7A929740FA5349B8@Viper-RSG.pc.cognex.com>
References: <48AC4CE6F0887542B2A5E28E4E7A929740FA5349A9@Viper-RSG.pc.cognex.com>
 <20131016201210.GR27238@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: John Keeping <john@keeping.me.uk>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:27:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYcm-0002WI-07
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759630Ab3JPV1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:27:20 -0400
Received: from mx2.cognex.com ([198.232.29.14]:14152 "EHLO mx2.cognex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251Ab3JPV1T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Oct 2013 17:27:19 -0400
X-Host-mx2: True
X-IronPort-AV: E=Sophos;i="4.93,509,1378872000"; 
   d="scan'208";a="6677792"
Received: from cook.cognex.com ([10.10.128.31])
  by mx2.cognex.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Oct 2013 17:27:18 -0400
Received: from BMUS.pc.cognex.com (bmus.pc.cognex.com [10.3.160.93])
	by cook.cognex.com (8.14.3/8.14.3) with ESMTP id r9GLRHT8006280;
	Wed, 16 Oct 2013 17:27:18 -0400 (EDT)
Received: from Viper-RSG.pc.cognex.com ([::1]) by BMUS.pc.cognex.com
 ([10.3.160.93]) with mapi; Wed, 16 Oct 2013 17:27:09 -0400
Thread-Topic: Pull and fetch don't honor `--progress` flag
Thread-Index: Ac7KrA7VFVhW2oLMQDmqE2cGDn8eygACQqyw
In-Reply-To: <20131016201210.GR27238@serenity.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236262>

> Does it make a difference how you invoke "git fetch"?  From a quick look at
> the code, "git fetch" with no remote or refspec should display progress data,
> but if you specify "--all" or a remote and refspec then it won't.

Thanks for your prompt response.  However, it doesn't make any
difference.  The behavior remains the same even without specifying
a refspec.  For example:

    $ git pull
    remote: Counting objects: 5, done.
    remote: Compressing objects: 100% (3/3), done.
    remote: Total 3 (delta 1), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.

    $ git fetch
    remote: Counting objects: 5, done.
    remote: Compressing objects: 100% (3/3), done.
    remote: Total 3 (delta 1), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done. 
