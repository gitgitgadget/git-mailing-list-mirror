From: Rudinei Goi Roecker <rudineigr@itflex.com.br>
Subject: Re: Git config not working correctly with included configurations
Date: Tue, 12 Apr 2016 13:03:58 -0300
Message-ID: <assp.09106d5289.570D1C6E.50303@itflex.com.br>
References: <570CDB33.9020300@itflex.com.br>
 <20160412155000.GA21249@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 12 18:04:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq0nQ-0001kF-Vc
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 18:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965486AbcDLQEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 12:04:04 -0400
Received: from uni.itflex.com.br ([177.200.204.249]:57206 "EHLO
	mail.itflex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965342AbcDLQED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 12:04:03 -0400
Received: (qmail 18142 invoked by uid 49); 12 Apr 2016 16:03:58 -0000
Received: from 127.0.0.1 (rudineigr@itflex.com.br@127.0.0.1) by web.itflex.com.br (envelope-from <rudineigr@itflex.com.br>, uid 89) with qmail-scanner-2.05 
 (clamdscan: 0.95.2/9450.  
 Clear:RC:1(127.0.0.1):. 
 Processed in 0.009024 secs); 12 Apr 2016 16:03:58 -0000
Received: from unknown (HELO ASSP.nospam) (rudineigr@itflex.com.br@127.0.0.1)
  by web.itflex.com.br with ESMTPA; 12 Apr 2016 16:03:58 -0000
Received: from rudineigr.itflex.lan ([192.168.47.195] helo=rudineigr.itflex.lan)
	by ASSP.nospam with ESMTPS(AES128-SHA) (ASSP 1.10.1); 12 Apr 2016 13:03:58 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <20160412155000.GA21249@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291272>

Thanks, I didn't knew about that option, as Jeff King said, the 
documentation is way more explicit about how it works in 2.8.0

On 12-04-2016 12:50, Jeff King wrote:
> On Tue, Apr 12, 2016 at 08:25:39AM -0300, Rudinei Goi Roecker wrote:
>
>> I'm having a problem with included configurations in ~/.gitconfig, when
>> using this command:
>>
>> git config --global user.email
> You need to turn on "--includes" explicitly. From "git help config" in
> v2.8.0:
>
>    --[no-]includes
>      Respect include.* directives in config files when looking up
>      values. Defaults to off when a specific file is given (e.g., using
>      --file, --global, etc) and on when searching all config files.
>
>> I'm using Fedora 23, git version 2.5.5
> The rule above has always been the case, but the documentation made it
> more clear in v2.8.0.
>
> -Peff
