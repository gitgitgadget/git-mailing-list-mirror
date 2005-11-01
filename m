From: Duncan Mac Leod <duncan@excelsior-online.org>
Subject: git-pull - strange (copy/rename) messages ?!
Date: Tue, 01 Nov 2005 16:40:35 +0100
Organization: EXCELSIOR developers Team
Message-ID: <43678C73.1080601@excelsior-online.org>
Reply-To: duncan@excelsior-online.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 01 16:43:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWyFD-0007Lx-AT
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 16:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVKAPkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 10:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbVKAPkL
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 10:40:11 -0500
Received: from rocksdale.excelsior-online.org ([213.202.239.5]:57094 "EHLO
	rocksdale.excelsior-online.org") by vger.kernel.org with ESMTP
	id S1750905AbVKAPkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 10:40:10 -0500
Received: from [192.168.2.2] (p5494D958.dip.t-dialin.net [84.148.217.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rocksdale.excelsior-online.org (Postfix) with ESMTP id 061384DAF5
	for <git@vger.kernel.org>; Tue,  1 Nov 2005 16:49:06 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051101)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10936>

One Team-Member of our dev.-team has deleted one file called 
Graphics/PaletteGroups.cs in our shared git repository.

As I updated my working dir with git-pull I noticed some strange messages...

What do these many copy and rename messages below the summary '14 files 
changed, 933 insertions(+), 263 deletions(-)' mean ????

Updating from f0df62e7b60c468852d4617505876515f9b305d7 to 
8c18245869a9447329dedb4a4cd59d103ee6dbfe.
Fast forward
  AssemblyInfo.cs                             |    2
  BaseObjects/Modules.cs                      |  235 ++++++++
  Graphics/PaletteCategories.cs               |   12
  Plot/Dialogs/Dialog.cs                      |   12
  Plot/Dialogs/DialogEntry.cs                 |   12
  Plot/Dialogs/DialogSection.cs               |   14
  Plot/Journals/Journal.cs                    |   12
  Plot/Journals/JournalEntry.cs               |   12
  Plot/Journals/JournalSection.cs             |   14
  Runtime/CompilerServices/eScriptCompiler.cs |   12
  Runtime/Scripting/Script.cs                 |   12
  Runtime/Scripting/ScriptLibrary.cs          |   14
  doc/excelsior_corelib.xml                   |  784 
++++++++++++++++++++-------
  excelsior_corelib.csproj                    |   49 ++
  14 files changed, 933 insertions(+), 263 deletions(-)
  copy Graphics/{PaletteGroups.cs => PaletteCategories.cs} (80%)
  copy Graphics/PaletteGroups.cs => Plot/Dialogs/Dialog.cs (75%)
  copy Graphics/PaletteGroups.cs => Plot/Dialogs/DialogEntry.cs (74%)
  copy Graphics/PaletteGroups.cs => Plot/Dialogs/DialogSection.cs (64%)
  copy Graphics/PaletteGroups.cs => Plot/Journals/Journal.cs (75%)
  copy Graphics/PaletteGroups.cs => Plot/Journals/JournalEntry.cs (73%)
  copy Graphics/PaletteGroups.cs => Plot/Journals/JournalSection.cs (64%)
  copy Graphics/PaletteGroups.cs => 
Runtime/CompilerServices/eScriptCompiler.cs (74%)
  copy Graphics/PaletteGroups.cs => Runtime/Scripting/Script.cs (75%)
  rename Graphics/PaletteGroups.cs => Runtime/Scripting/ScriptLibrary.cs 
(64%)

thx in advance,
duncan
