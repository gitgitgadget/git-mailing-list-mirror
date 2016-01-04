From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 17/17] test-sha1-array: read command stream with
 strbuf_getline_crlf()
Date: Mon, 4 Jan 2016 13:27:49 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601041323550.14434@virtualbox>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com> <1450303398-25900-1-git-send-email-gitster@pobox.com> <1450303398-25900-18-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 13:28:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG4F3-0007mf-6b
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 13:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbcADM16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 07:27:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:65018 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753680AbcADM1z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 07:27:55 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LnDof-1ZkbRT37Er-00hK2F; Mon, 04 Jan 2016 13:27:50
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1450303398-25900-18-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:T5sP5EFEU4K4WTYcl8t5joy8NFOhT0Uh172+IdHlIZMvb7IXgvP
 lEcn0ECTYWTd2sBARFPnSw/1+Auir4+WjKbmAToInmo5BVhyXEaQ7KLb8R1/y+58dYO9ux3
 20pZNXcM2mKRDjAkdtWQ4mXUjqK3o/UJZpL1zbWj4LMrrnd5tHbcA+kkjumUUSuOaRn9YDa
 25h2jouvTSXdamVki75RQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fCgabEPeCbo=:gj3O3TyFss8a1jQD9zpFqd
 1TOBp/n2wdLMhW+zhC8s3y4Iu05ElEFFbW/kb1g8ZPJETdImSnWIz7j9oRrsg0aesNMTYpHF8
 2YQgt1VTV7jNRC8+9x7oaTJ80iNSa6M1nV9jPtVupFp9jhEAfLKuj9lw++b8XOYQ7+cA9KYbF
 etztxJBZXjEybzScTxxhdVlNkEHMlzUI2NVRPzfq7eHgoobhTIELQml3e7k00wbMeDDusCZXm
 bljDF5TydukUIZMlE8tn7xA3evR5wfGGNrt5b7ar+L678gCnKc91Do9bdecrJ5r0RZR1nWug3
 trKJWf9tkLoXbsvmc6Wt812KEtpS0IohRw+d9Jmnri5liJXNv7gYbbBW/R1Jt8dkZbVpLJQ8Z
 IWnyxzJKQvTgz+mVv4IblWtOcx/RnZ05Ygj2fZLz0R1BdLtl8FnYv9p+IguaPz4lanUE6huoc
 w7VGltf/RwVCgEsAuCbeVk0gJ35oN5ZpxySyRJL3RcvQA6syx4BJOFt4Ngp3Zhhsy7SwoDuIW
 c3fqFvPhXOCYtisDPlTMW4258HmfeJKwv2QLmlm+PmK31Yu8NqRXFWRXQayKYKiv51N+V/WAy
 FPNZVPnA2o8i3GQ+/L6ryQAMyxvSJq4Bds8xR7UxGAPtxEm6b5G8A5laQo84pj7snwXgmGoXq
 vLLTjRuW+Hv/kJdrFpYfa886gMhqW5vw4koJIgiV77MdKpwcQ14MARlK7AtydLwnKcazaxsde
 tMioX+e38SPDwXYY9FmowbhYjKLAP0mKDVBNe9ipbgLhQezHtF1uu4lOiebHDfHJJWca9DC9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283306>

Hi Junio,

I read through the entire series. I hope you find my comments helpful.

Happy new year,
Dscho
