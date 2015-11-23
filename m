From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Nov 2015, #03; Fri, 20)
Date: Mon, 23 Nov 2015 14:09:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511231407380.1686@s15462909.onlinehome-server.info>
References: <20151120140937.GA17079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 23 14:11:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0qti-00041u-FE
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 14:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbbKWNKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 08:10:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:64372 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413AbbKWNJz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 08:09:55 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MBnvD-1a9y633idT-00AmQk;
 Mon, 23 Nov 2015 14:09:44 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20151120140937.GA17079@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ZJp9F9OcpYKpAqOKwiV/eIjjkDpod/Ba5DSJ2SUy0Qd9VTPg+rU
 trDIQCtGRu2wPpj5j/2ZbzPK+ataFdEQ9dPDWya+mkqLpQHVZtSqNfDW5elwBnHYqdR5Kan
 p60B4iH1f9gTKSapKul6m5/CLTwW61LhAfr3T09plwGklPHrgY9O5seBzOk+ZNHV6kS50so
 ppwl8AX5tnAGHJa2ocwdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ThkR4XlADRk=:UPo88uDOuiuAWsn3CUJkDO
 ZEWevJyFyKR3UZfCZu2IDA5S9Cgtqd+TZnjOOf07/a7IKp8Yf2l0+MkE7eCC6tuW979z7f4zQ
 XlpJIivmgfLJfOZ5GURhcG5o7lfqoU2Qh+Fzoo1RmXnTuBc80wBX14wwvW+91gQcMSk4Or9dC
 ZsiFef//ukLmxjpASvGBfm+m54mRGjOn3Bcivgt4qylaxRO/m5XTECJlLsqvJyjR9Nofv2Mnh
 nzJTNFNBtu0UscEgdxvAUvQNMmTQSZK+EjXZMOT/xEBnuDCpFZNnzO5uGtn1CsmaZuEvEZNtb
 bxa3KDiQOjcS2HXWl2D0h6uAY88/6oz0/e4rYpFQRmhfoPn8b57kOUJH8qxtkbYoVdEAEqff+
 ZL9zKs+PkP62NHrp7++Tdh1dwneurtGJyeJL80DQ3FGEOTGTK54kN9tApvASYtqrSGxSa8I+/
 JXBPLUndF3mMmsFpirh8rxq8IfEY+lUfosQLUlP7F38xk2gkuogt55MnJJMsVGV1TeyQK5OQH
 yJAoHHpO+WSDCHtbvwis+Blo6deGLqfz0kPh4GwRmWRJpbFgvlsNRdvkN1Lf1E55gI44Z2w/4
 fTMqnfddXVHA0yY/ZNGGRP6R+1C9IVNSwFR9vampJ1MR3gmYHRV+3Ie4ATG2+bqsQcpcmrRGI
 Wmvpwy44Kkpjx8YWAZSC1NEOA+3B/YGBEFHbEyoCWptMbZQyM8uLv+1HHuAbIKDG4Wsln4CfC
 k7EGi3ad+FsDH+saUIJ/W3zRz4l5CEU9AMIe7ozmqdWYQgQ8OXtrcWhcw5mbj606X0LulntG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281584>

Hi Peff,

On Fri, 20 Nov 2015, Jeff King wrote:

> * pt/http-socks-proxy (2015-11-20) 1 commit
>   (merged to 'next' on 2015-11-20 at dc6ae48)
>  + remote-http(s): support SOCKS proxies
> 
>  Add support for talking http/https over socks proxy.
> 
>  Will cook in 'next'.

With all due respect, I do not thing this needs more cooking, as it

1. was tested extensively by yours truly in the Git for Windows context,
   and it

2. cannot possibly break anything because it tests specifically for the
   "socks:" prefix. It is a pure new feature.

Ciao,
Johannes
