From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 01/43] refs.c: create a public version of
 verify_refname_available
Date: Sat, 3 Oct 2015 07:02:42 +0200
Message-ID: <560F6172.3040404@web.de>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
 <1443477738-32023-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Oct 03 07:03:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiEyz-0007Jt-A2
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 07:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbbJCFDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 01:03:08 -0400
Received: from mout.web.de ([212.227.17.11]:53121 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbbJCFDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 01:03:07 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MSai0-1a7RMu2Vzo-00Ra66; Sat, 03 Oct 2015 07:03:00
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <1443477738-32023-2-git-send-email-dturner@twopensource.com>
X-Provags-ID: V03:K0:4qqPpY/Fueg+8LJtecXVvsN+auLGPqe7Bpf3JA1HcZ5t23DQozj
 FCpWRjfjXx8K+SaHeHQRIm/XrOOSX2BWql735X8iLs0+6y+6UghgTW8CJ8U4VcuAfojhMmc
 PmSJ7/lB9G+KnhcTKboL5+IIGq1pOltcHznA9Nccn13Jv3R1mcSqF21N1v9h+qXs3l4SDnF
 26Hc+mHUnJag+j4Aq2VJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jThzfytdlAo=:zB89H5oGuIzLcJyUjtOrVG
 kO5QgcG02awGdFbQTfXDrfvwAPCK0Asd2yT8x1oEUYoBl9Xu9MJROtIFBvIGzoxNuWelGQOqT
 6G0PJq9EAcBpVB2qBU+G2u8HBz0QdIxoFaLGOwbkD1zonAvV7cgpJanlvNF7D8UK1IRLG0Zx4
 dvIB7fRktTNOu5KOONwMOH7gFHd9Nx8YcMSHcw/+37G/rP2hcdJDo3j7f9jZdvP9HKWCu7gTw
 PwBxVOzzdCp8Lm2hXzcD0wquNE8k+8O4VBwvwpGmY4mgPhQIptnAaktmx9h6JiR3juh4r04dT
 6xGhjYbKuB2cecuh6/UP53KUjfnoK+km8uaqG5BaeS7a3ntFN5+1YL+RckTYoAQen0pvCmfAW
 H1AjSwU1oITXeqKVrv/rTKtovyYTkbokjq5oApMqv0b+T+gcLNHazU1Yit2gfTdBKsQuH6Ruj
 rxdabnDGIgP4EzGZNbb7tAWwCvroWgH0yH7P7JIJejckaSsvxrZpExyt1tkh/RZrExa8wJTJg
 UhSYBjrfaPn4AIHtxAvW7WlDOp78hKemGE/P812Z/4lr84fsI1JJRXVFTIUdGQtWWahTSDy+a
 Swkmv7yPOeMshb4/631y/F2a4sPgvSvF591GlU4Oc64X91BDfd789bIKZ9f9Qd/RJRtWk33uI
 dpy2Y8vDSBDB/z3RWwEeuiSyI/VaSF4ugFHS79MJWM3X8tDlYOEvp5Hm8kgf8/P5k8YpZbi8s
 OaVVA0rnLBs5xNOMamJgnJcm8YBVjcZK64U8wl6zla/l8P5p4GKiZgSR3p4dq5zrGDt8qizz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278954>

On 29.09.15 00:01, David Turner wrote:
>
(Not sure if this is the right thread to report on)

In file included from builtin/commit.c:20:
./refs.h:695:16: warning: redefinition of typedef 'ref_transaction_free_fn' is a C11 feature
      [-Wtypedef-redefinition]
typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
               ^
