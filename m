From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Thu, 12 Oct 2006 15:15:10 -0700
Message-ID: <452EBE6E.6040802@gmail.com>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com> <7vlknlmc9y.fsf@assigned-by-dhcp.cox.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexei Podtelezhnikov <apodtele@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 00:34:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY8po-0007lE-0o
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWJLWPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWJLWPV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:15:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:44606 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751188AbWJLWPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 18:15:20 -0400
Received: by ug-out-1314.google.com with SMTP id o38so375562ugd
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 15:15:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Gdzf6bZYy532L99GTICd12VpymtEhtIaXGg8dNpWom29TAs9vRn9ZWKf/PrFCvYRkJl/iE5FERRxU4pe0jyOOe3lvJka7IDzlvCYZwDgQ3nUO+Au/H00kmXOuMFhhJJs8RxTY9alCYgaqoMDEZZnMo3U+3/O3Zntvt5jct/LyoY=
Received: by 10.78.185.7 with SMTP id i7mr2806458huf;
        Thu, 12 Oct 2006 15:15:18 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.google.com with ESMTP id 15sm2619433hui.2006.10.12.15.15.17;
        Thu, 12 Oct 2006 15:15:18 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlknlmc9y.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28808>

Junio C Hamano wrote:
[...]
 >
 > We could align things in the middle, like this, though:
 >
 >          A |    ++++++++++++--------
 >          B |        ++++++++------------
 >          C | +++++++++++++++---------------

This is more diff like and makes comparing the right and left side 
changes easier.

          A |        --------@++++++++++++    |
          B |    ------------@++++++++        |
          C | ---------------@+++++++++++++++ |
