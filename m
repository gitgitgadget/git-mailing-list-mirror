From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [BUG] Fail to add a module in a subdirectory if module is already
 cloned
Date: Tue, 24 Jan 2012 22:13:52 +0100
Message-ID: <4F1F1F10.7020907@web.de>
References: <jfmvpp$4v7$1@dough.gmane.org> <4F1F1E5F.2030509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jehan Bing <jehan@orb.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 22:13:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpngk-0002tL-K6
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 22:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628Ab2AXVNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 16:13:54 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:37997 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844Ab2AXVNy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 16:13:54 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate05.web.de (Postfix) with ESMTP id 101B36947319
	for <git@vger.kernel.org>; Tue, 24 Jan 2012 22:13:53 +0100 (CET)
Received: from [192.168.178.43] ([91.3.157.14]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LtX9Q-1SoX9o3dMC-011FwO; Tue, 24 Jan 2012 22:13:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F1F1E5F.2030509@web.de>
X-Provags-ID: V02:K0:2avRjsMhK9TXeSeA+M42qIVMhnapKYljduMXwKZZAuz
 +WgydkbbBoP5AvUKJPy7ANVNqy4pgzSDf9Nx4oJyHi0fU749uN
 wBMIOej7BcDKFnYgXiIgZsC2f1rncRcTI6dcxBEIB64dVJMx29
 Ux0nhlDnpHikRX5Nmj6oK7h4Fa3Pz+IiqXTX19ng9m+IT3IXCi
 BRmB7ull7t9ZRoL9tBazg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189070>

Am 24.01.2012 22:10, schrieb Jens Lehmann:
> The reason for this bug seems to be that in module_clonse() the name is
> not properly initialized for added submodules ...

This should have read "for re-added submodules" ...
