From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: git-remote and remotes with '.' in their names
Date: Wed, 28 Feb 2007 15:55:11 +0100
Message-ID: <45E597CF.9000009@lu.unisi.ch>
References: <87k5y5tlol.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Collins <paul@briny.ondioline.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 15:56:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQDi-0003MM-1B
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 15:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbXB1OzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 09:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932945AbXB1OzP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 09:55:15 -0500
Received: from server.usilu.net ([195.176.178.200]:45578 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932943AbXB1OzO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 09:55:14 -0500
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 28 Feb 2007 15:55:11 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <87k5y5tlol.fsf@briny.internal.ondioline.org>
X-OriginalArrivalTime: 28 Feb 2007 14:55:11.0495 (UTC) FILETIME=[72313970:01C75B48]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40930>

Hello,

>  	for (@remotes) {
> -		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
> +		if (/^remote\.(.*)\.(\S*)\s+(.*)$/) {

You probably want either

+		if (/^remote\.(\S*)\.(\S*)\s+(.*)$/) {

or

+		if (/^remote\.(\S*)\.([^.]*)\s+(.*)$/) {

here.

Paolo
