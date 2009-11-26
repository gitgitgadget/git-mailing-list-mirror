From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH/RFC 02/11] strbuf: add non-variadic function    strbuf_vaddf()
Date: Thu, 26 Nov 2009 12:13:11 +0100
Message-ID: <helns7$mha$1@ger.gmane.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>	 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>	 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>	 <7vskc2ksnn.fsf@alter.siamese.dyndns.org> <40aa078e0911260238rd0c90cag126709d1de5f50de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 12:13:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDcI9-0000On-0n
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 12:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759369AbZKZLN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 06:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758958AbZKZLN2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 06:13:28 -0500
Received: from lo.gmane.org ([80.91.229.12]:42918 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758500AbZKZLN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 06:13:28 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NDcI1-0000LR-Sc
	for git@vger.kernel.org; Thu, 26 Nov 2009 12:13:33 +0100
Received: from nat-pool-brq-t.redhat.com ([209.132.186.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 12:13:33 +0100
Received: from bonzini by nat-pool-brq-t.redhat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 12:13:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-pool-brq-t.redhat.com
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090922 Fedora/3.0-3.9.b4.fc12 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <40aa078e0911260238rd0c90cag126709d1de5f50de@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133785>

On 11/26/2009 11:38 AM, Erik Faye-Lund wrote:
> In practice it seems that something like the following works
> portably-enough for many applications, dunno if it's something we'll
> be happy with:
> #ifndef va_copy
> #define va_copy(a,b) ((a) = (b))
> #endif

Yes, this is correct.

Paolo
