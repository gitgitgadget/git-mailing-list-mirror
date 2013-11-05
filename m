From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: rcs
Date: Tue, 05 Nov 2013 15:56:27 +0100
Message-ID: <5279071B.2070309@gmail.com>
References: <B49EE6A27F1B0642B4D12AD9C064E8C7B072E3@SOARCPRVSBEU000.regnet2.soar.ns> <20131029181614.GA13601@sigill.intra.peff.net> <B49EE6A27F1B0642B4D12AD9C064E8C7B072E5@SOARCPRVSBEU000.regnet2.soar.ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Hawkins, Lisa M Mrs CTR USA USASOC-SOAR" 
	<lisa.hawkins1.ctr@soar.army.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 05 15:56:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vdi3g-000817-UM
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 15:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126Ab3KEO4l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Nov 2013 09:56:41 -0500
Received: from plane.gmane.org ([80.91.229.3]:32836 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807Ab3KEO4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 09:56:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Vdi3a-0007hs-4F
	for git@vger.kernel.org; Tue, 05 Nov 2013 15:56:38 +0100
Received: from 158.75.2.83 ([158.75.2.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Nov 2013 15:56:38 +0100
Received: from jnareb by 158.75.2.83 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Nov 2013 15:56:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 158.75.2.83
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <B49EE6A27F1B0642B4D12AD9C064E8C7B072E5@SOARCPRVSBEU000.regnet2.soar.ns>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237330>

=46innerty, James M Mr CTR USA USASOC-SOAR wrote
> Jeff King [mailto:peff@peff.net]wrote:
>> On Tue, Oct 29, 2013 at 11:35:21AM -0500, Finnerty, James M Mr CTR U=
SA USASOC-SOAR wrote:
>>
>>> Hi. I'm going to attempt to import a git database into Razor which =
is
>>> linux rcs based. Does the linux version of git use rcs ?
>>
>> No, the formats are completely different, and you will have to trans=
late.
 >> We don't usually get requests to go from git to rcs; it usually goe=
s
 >> the other way. :)

 >
 >    Thanks.  We have several systems using Razor right now. So we are
 > trying to get all the systems into one CM system. Razor is just a gu=
i
 > that uses rcs commands. Once we get everything synced we will explor=
e
 > our options for a complete development CM system.

The problem with using RCS as sync (as base) is that it is least
powerfull of VCS, and as far as I know do not offer place to store
extra information, so conversion from Git to RSS will lose some
information (committership, signed commits and signed merges, signed
tags, etc.).

There is a tool to create fast-import stream from RCS repository,
but I am not sure if there is reverse (fast-import is a common
intermediate fairly VCS_agnostic representation used for fast
conversion between different version control systems).

--=20
Jakub Nar=C4=99bski
