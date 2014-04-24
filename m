From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 3/9] tests: new test for orderfile options
Date: Thu, 24 Apr 2014 10:11:29 -0700
Message-ID: <20140424171128.GI15516@google.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
 <1398331809-11309-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	gitster@pobox.com
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 19:11:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdNBW-0001lh-S3
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 19:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758555AbaDXRLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 13:11:38 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43982 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758420AbaDXRLd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 13:11:33 -0400
Received: by mail-pa0-f43.google.com with SMTP id rd3so290304pab.16
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KDlBn4d+Spi7TfNaJZvcA9h75UYpgZf/YYtFhksQ95c=;
        b=augp8jAURGbW8HnHW3daCV6tiDaeSEHRqxJ34fb8pCJAEOC96bNJNINzSFTJ/zdBTw
         GjA6Nq902LQdf/Ev327uXgINmYyRAMC263Dk5rVTZEhmOjfziBKI9ANZYaptykMI5MCK
         ci7+MuxzdkClLhf+nt9BmJ34VZhtmUSOBv1O0IrSbUjtrLBiCxvsFQVCPZoVEBEPEZco
         VS2PltoLHUqM2OvjooR7H3Cop76OLt1G8Qqkn/LEVjd4ihBY8CR5Ki0seVlympiWFd2x
         /MS50jJOOVlgKXV4eE7k25j1OxTpf9sk2qBpypbXXZwhUovK2IoGJXJa0p/tzxWo1/cF
         P4QQ==
X-Received: by 10.66.166.233 with SMTP id zj9mr1465714pab.75.1398359492839;
        Thu, 24 Apr 2014 10:11:32 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xk1sm23307387pac.21.2014.04.24.10.11.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 10:11:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398331809-11309-3-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246977>

Michael S. Tsirkin wrote:

>  t/t4056-diff-order.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100755 t/t4056-diff-order.sh

I thought this file already existed since v1.9-rc0~8^2~3 (t4056: add
new tests for "git diff -O", 2013-12-18).

What commit is your series based against?

Puzzled,
Jonathan
