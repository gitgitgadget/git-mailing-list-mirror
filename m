From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Mon, 03 Aug 2009 15:31:58 -0700
Message-ID: <4A77655E.3010902@zytor.com>
References: <4A7735B0.2040703@zytor.com> <7vocqw8u0x.fsf@alter.siamese.dyndns.org> 	<4A7760FD.8020705@zytor.com> <fabb9a1e0908031521q579a9bf0ta834b2c9253e58e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 00:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY64p-0005J5-Kd
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 00:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbZHCWcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 18:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbZHCWcL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 18:32:11 -0400
Received: from terminus.zytor.com ([198.137.202.10]:50987 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbZHCWcK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 18:32:10 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n73MVwaT014743
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 3 Aug 2009 15:32:04 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Thunderbird/3.0b2
In-Reply-To: <fabb9a1e0908031521q579a9bf0ta834b2c9253e58e9@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.94.2/9648/Mon Aug  3 06:27:08 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124733>

On 08/03/2009 03:21 PM, Sverre Rabbelier wrote:
> Heya,
> 
> On Mon, Aug 3, 2009 at 15:13, H. Peter Anvin<hpa@zytor.com> wrote:
>> Yes, that's what they suggested, too.  Like I need an extra step in my
>> patch process.
> 
> Write your own git-lazy-am.sh and put it in your path?
> 
> cat > git-lazy-am.sh << EOF
> #!/bin/bash
> 
> dos2unix "$@" | git am
> EOF

Yes, I can do that.  However, having this integrated into git am would
be nicer not just for me but for everyone else.

(Currently I'm just using apply.whitespace = fix, which also solves the
issue.)

	-hpa
