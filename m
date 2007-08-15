From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 15 Aug 2007 07:43:15 +0200
Message-ID: <ABA1D7D2-92A6-4E8C-AC36-93912621E3D4@zib.de>
References: <f99cem$4a4$1@sea.gmane.org> <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com> <Pine.LNX.4.64.0708081810130.14781@racer.site> <75EB313E-807D-44FB-A186-A151F182B47B@zib.de> <Pine.LNX.4.64.0708082228520.21857@racer.site> <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de> <e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com> <2383328F-300E-459C-A299-90242DA230F7@zib.de> <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com> <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de> <e7bda7770708141704m587dfdbdqfbab51b8ac6fcff@mail.gmail.com> <30FE2B1C-B651-4F1D-B5D9-CD3C3261F531@zib.de> <85fy2l1i1g.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Torgil Svensson <torgil.svensson@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 07:42:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILBeX-0005mO-3t
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 07:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbXHOFmk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 01:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbXHOFmj
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 01:42:39 -0400
Received: from mailer.zib.de ([130.73.108.11]:50424 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbXHOFmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 01:42:39 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7F5gV3R024113;
	Wed, 15 Aug 2007 07:42:31 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1a5ff.pool.einsundeins.de [77.177.165.255])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7F5gUaW028688
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 15 Aug 2007 07:42:30 +0200 (MEST)
In-Reply-To: <85fy2l1i1g.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55880>


On Aug 15, 2007, at 7:30 AM, David Kastrup wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> Author: Johannes Schmidt-Ehrenberg <schmidt-ehrenberg@zib.de>
>> Date:   Mon Aug 13 19:00:39 2007 +0200
>>
>>     mergetool: fixed parsing of registry entry for kdiff3
>>
>>     The old code failed on Windows Vista. The output of
>>     reg.exe or something else may be a bit different.
>>     This patch improves the parsing code to be more robust.
>
> I seem to remember that you can't rely on reg.exe being available on
> Windows.  The Microsoft support pages talk about using regedit.exe
> instead (which is quite more cumbersome).

I successfully ran it on at least Windows XP and Vista. On Vista,
it was present on a quite fresh system (Visual Studio not yet
installed). So I'm quite confident that it's likely to be there.

Do you have a reference? I searched msdn and was not able to
immediately find the recommendation you're referring to.

	Steffen
