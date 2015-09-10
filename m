From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 20:58:49 +0200
Organization: gmx
Message-ID: <74514591d4cd502eee06cde3e099e656@dscho.org>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:59:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za73i-0005S8-DO
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 20:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbbIJS6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 14:58:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:56099 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbbIJS6x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 14:58:53 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MGjL7-1ZMemx1wor-00DXyx; Thu, 10 Sep 2015 20:58:50
 +0200
In-Reply-To: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:/TqkSuRUmB+CqhBk8y5hjVRnGitZgD7EtyPK6l37iWbPlAlu61c
 eqd++xBgaNIU/IOv7LJtqi9w4Fxcyb73g5UFwivC5D1yiM+eEUFvbTvoffRg52X/6DDHiAa
 1WFLRLCr9rQkz7xB54nb62xHKBqB1iEhM+VkmZQ/v76cLtAXfTmkmsJi6E6uADA13W+h6RY
 PBCO9FEigT27C5DgO6bmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:avaGHdAfyIU=:8n/vYaFbTFRuuWoPujmvoS
 giEVlEVzPKIWAGswwXnGSr3qUCoYDPTwl+f3FfuazA2ap+CJuG7SO16cZZ2xQw7vAHtJyXUEu
 gm9hdaogs0pBv+FsqUcL8rFIINzPj/8Ih+afyo4HVCbO7XJz5LP3fR7KkQHKzKPVnws4HMjzi
 IFFKFhSjgzi71NIB8PFtCcybemmYBYmKkqk7gfv8CzeASdDdymL71VZkNPZ4NRnYMsXd2KdpA
 C6+qkjvew9rx2zjPeCYODh+lhysiFfydXyegv4Tf7X2L5RidUsC4wvrOeIxaB78h1Vk4I3Y+v
 MPKjxeFGUnveuP2hlY2m8NFempn/VIrFKCXmRjuYvEBT9geLKCUYdH7RvB5ZyEuvcrYL0sUSE
 BY35HMZ30xy8BF1RtQ4ctPCjp+/ulErssa5+Xl4vUcg/5sB+6kPzdM8NzkF5/AqgYzinHK1dU
 qLqZZWaAwFO6GjQGP/BWL9uPG9GdMHODDPF8CDkuL/5XQzN5QKD47pXQT+BkRYCxUS4BvuQNQ
 QoCKrOCjLdd3KgPEDKUmm0aZXIp+wNqhAmD2XJjEhYjMQvHOvyyN1GVcEpyZn0GITwPXRsAkd
 5LC3wl2S7VQG51LOriw0uCv/5hqVlr8z5B5FNZpRIfVFHUErs/L2sE8p4k8SUkJi4BUGxYBk+
 NVR/pNhLagzIwwG58Yr08LKod15YZ4mM5W326yh96tnFrJvk/ZyHb432nUE602ACQgSZCHUaL
 hlEtCctTKZtURhTUbqbq9QwLQvLVFATRv7nGeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277628>

Hi Jake,

On 2015-09-10 18:28, Jacob Keller wrote:

> does anyone know of any tricks for storing a cover letter for a patch
> series inside of git somehow?

It is not stored as a blob, but I use `git branch --edit-description` to write the cover letter for patch series when I expect a couple of iterations.

Ciao,
Dscho
