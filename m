From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: RE: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Wed, 18 Mar 2015 10:24:29 +0100
Organization: gmx
Message-ID: <457620dde2d2e403a564889367f43955@www.dscho.org>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
 <000701d06156$dd3145e0$9793d1a0$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: 'Paul Tan' <pyokagan@gmail.com>, git@vger.kernel.org,
	'Duy Nguyen' <pclouds@gmail.com>
To: Stephen Robin <stephen.robin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 10:24:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYADS-00059C-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbbCRJYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:24:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:51976 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754744AbbCRJYb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:24:31 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LnUna-1ZBNBL3mGM-00hd8i; Wed, 18 Mar 2015 10:24:29
 +0100
In-Reply-To: <000701d06156$dd3145e0$9793d1a0$@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:JYtTnSaPFXgguYzt+qt6MpXMO/Lwz2cKp6CrhQ8E9uQd3yq9BXh
 EzLGl/APMVmlMIh+Q+fCldI42BdezP1lHPZnjCexlvDoKCOxkXGN9TJSLp1Ol/XoIa15+KV
 AmsB/Hf3Mo93A3wAvpj9DA0z0z2MppDDDQ7SN3a0qxnFwMJAoS8EbBrnMSAuzvNVHZox/B/
 dbAeYDxa13B31z7n0SfDQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265699>

Hi Stephen,

On 2015-03-18 09:38, Stephen Robin wrote:
>> Paul Tan writes:
>> I would like to share this very rough prototype with everyone.
> ...
>> I started this as a just-for-fun exercise to learn about the git internal
> API
> 
> I started to rewrite git-pull for similar reasons a couple of months ago,
> but I haven't had time to complete it.  It looks like my version has less
> work remaining than yours, would you like me to share it?

Hmm. It always results in an unnecessary round trip if you ask people to ask you to share it.

At this point, because Paul already made his work public, I would say that we should continue with his version. Please understand this as an encouragement for the future to share your code pro-actively, just like Git's own source code has been shared with you without the need for you to request it explicitly.

For the record, Duy also already shared his C code to implement `git pull` in C publicly. I think that Paul decided to start again in order to understand every detail of the process of converting a shell script into a builtin; If that was the rationale, I would agree that it is a wise one.

Ciao,
Johannes
