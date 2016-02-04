From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git 2.7.0 crashes when top-down memory allocation preference is
 set
Date: Thu, 4 Feb 2016 08:46:07 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602040844330.2964@virtualbox>
References: <9e3cc44087134954a3414fa8998c3ce6@USNAEXCP2.pc.cognex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Klinger, Xia" <Xia.Klinger@cognex.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 08:46:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aREcM-0001ki-5n
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 08:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbcBDHqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 02:46:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:55125 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbcBDHqN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 02:46:13 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MS5Dm-1abnWk2TKk-00THd1; Thu, 04 Feb 2016 08:46:08
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <9e3cc44087134954a3414fa8998c3ce6@USNAEXCP2.pc.cognex.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:RPfF7EKFwNF6w+MAceCjkxD3eQvjE3pvt2BQUndbAHty94ZMKqz
 CgrxVkDrxsSIxS4UF4YW4LwdvIyWWe35D4c5kveIPame5rWxEztOQBfQNq+K8lPcxM3jNWp
 kxaUbxmBB42X65aFrHuYKtqd1OoWWrQw2+bCdsqmrKRVZbiuBpkHpSyer0QR2jA0G7r2bdg
 DfCjUrP0BwYKAZ6J6H0Ow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+UXRLmNYQdY=:iF3UwUCrNajgx3dxUtwfSE
 mFNg9+SHkXN134iTDakuj/a30twF+pBww7PzpM5FqpM35edmBqT8mYSNuJsUheQ/D5Gq+NGWB
 IqpIR0WWYVNhD92h5LLg8eIwLUDhwYbxllULlaoShwLA5dsAKXgOHmciAAdLNe4zDA8Qmtaqr
 DLNgkhumYO77iz3chnpU8uV0ZAUOLFo/X7oln8RBVPilOuiFKTQgTvdLn4x1WmBf2fR46VKWO
 KeVQSXNHluSGNMvZhY7N2rwnPKAPA0B5fz4PXax/qcIqjVrPMtxOghxWoajlGiqubaw7uBNIk
 e0T4+ZF6OduFxxRfjbvqFDLfVy6BHWCXRjD0BJctgyBFVHgyFfU1zKKxZ3mN4IZnwty1a2bd4
 wRS6fp6xnyYPTWT0fwJhWx+5r07k1LeFWRrZbJCFOcWONJGS+znuv0pXs9+1Dz+yaxBoP/N+G
 ZmBnU+dAwQo0KUjp/kJh4wmljzwZ84KltzPRKFcTP62cms7ebVTD8QKBMG2KRdG6K+YzImNQg
 WlzuEsihvHEEwzevKK0HqyrZfwx/1EPsHCAAorw7SDBFCxDtZ2YP8ktrpu1anADMZXGqNrSo4
 8ZMgSMmgNE2H1lF/9y0bsckZYEScz8y2hJDBW+QiwgwTXRNpsBi0cuWMBes3gcfs4WneG7T56
 L/Pl749um7Bt+EJHw8XKObTADgCSP199p3E6MNDQFcb6oh4rQtuVvOQNoQ1CTV6KvzsleYFGb
 rCAgIkYKKeNHYHfCI3LKsx2HbhNvmPVbm3WtZwhiMbfyxUYHMweHJJ5Xmmb7W4cNNTFc62P2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285402>

Hi,

On Wed, 3 Feb 2016, Klinger, Xia wrote:

> When the memory allocation preference is set to be Top-down on Windows
> and there are more than 4GB memory available, git will crash. The
> symptom is "Segmentation Fault".

This might be related to https://github.com/git-for-windows/git/issues/627

Do you have access to the Fast Track releases? If so, Windows 10 build
14257 was released to it and purportedly fixes these issues.

Ciao,
Johannes
