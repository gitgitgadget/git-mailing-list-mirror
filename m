From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean.francois.veillette@gmail.com>
Subject: problem with git cvsimport
Date: Fri, 31 Aug 2007 10:31:39 -0400
Message-ID: <A74F186F-7C25-48D5-9354-C74576439AF1@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 16:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR7Xm-0007Gl-Ud
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 16:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbXHaOcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 31 Aug 2007 10:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbXHaOcE
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 10:32:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:52751 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbXHaOb6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 10:31:58 -0400
Received: by py-out-1112.google.com with SMTP id u77so3503038pyb
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 07:31:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        b=l4jb4+GU2AjiKy/OaEt97hYxKWXYmTETB5jONkaoWi+IrlwCYZQLnEHq5MJkzy+Km1G39xVoHoUInErULhBh3p+buZpBD56d2wTquZNd/Px0vL/Gns8WQ3jtnM2VnKwxaGVr1Mr2qRWl+XQCxNJX06D8AOY8tRQeDrH0bVNS8U0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        b=EYpD6NDG2GrqsQXlpGsV41Tyo+ZzJtlyw/9dEOx57xnZpkmRmylMFQNJ2iXKXczSubH37TpWlB42lU+JFpAsZU6kByyqFmF+pMKWpQVvl7bpmHxlHUDIDpGGw7EHb9CfqPKQnA872KiVrjEQa2tBkflqzVthLSIv7cBnoKso6Tk=
Received: by 10.64.91.15 with SMTP id o15mr3491612qbb.1188570707408;
        Fri, 31 Aug 2007 07:31:47 -0700 (PDT)
Received: from ?192.168.3.32? ( [207.96.147.134])
        by mx.google.com with ESMTPS id f16sm924316qba.2007.08.31.07.31.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 07:31:42 -0700 (PDT)
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57169>

I can't get git-cvsimport to convert a cvs project to git (full log =20
bellow).
I always get :
	fatal: Not a valid object name refs/heads/HEAD
	read-tree failed: 32768

I'm a relatively new to git. I would like to convert my project and =20
track external projects with git.
But cvsimport seem to fail.  Any pointer to help me resolve the issue =20
is welcome !

thanks,

- jfv

Detail informations ...

host info (uname -a) :
Darwin localhost 8.10.0 Darwin Kernel Version 8.10.0: Wed May 23 =20
16:50:59 PDT 2007; root:xnu-792.21.3~1/RELEASE_PPC Power Macintosh =20
powerpc

git --version
git version 1.5.3.rc7.16.ge340d-dirty

cvsps version 2.1 (got the git repository, merged 'master' with =20
'multitag')

Perl (perl -V)
Summary of my perl5 (revision 5 version 8 subversion 6) configuration:
   Platform:
     osname=3Ddarwin, osvers=3D8.0, archname=3Ddarwin-thread-multi-2lev=
el
     uname=3D'darwin b07.apple.com 8.0 darwin kernel version 8.3.0: mon=
 =20
oct 3 20:04:04 pdt 2005; root:xnu-792.6.22.obj~2release_ppc power =20
macintosh powerpc '
     config_args=3D'-ds -e -Dprefix=3D/usr -Dccflags=3D-g  -pipe  -=20
Dldflags=3D-Dman3ext=3D3pm -Duseithreads -Duseshrplib'
     hint=3Drecommended, useposix=3Dtrue, d_sigaction=3Ddefine
     usethreads=3Ddefine use5005threads=3Dundef useithreads=3Ddefine =20
usemultiplicity=3Ddefine
     useperlio=3Ddefine d_sfio=3Dundef uselargefiles=3Ddefine usesocks=3D=
undef
     use64bitint=3Dundef use64bitall=3Dundef uselongdouble=3Dundef
     usemymalloc=3Dn, bincompat5005=3Dundef
   Compiler:
     cc=3D'cc', ccflags =3D'-g -pipe -fno-common -DPERL_DARWIN -no-cpp-=
=20
precomp -fno-strict-aliasing -I/usr/local/include',
     optimize=3D'-Os',
     cppflags=3D'-no-cpp-precomp -g -pipe -fno-common -DPERL_DARWIN -no=
-=20
cpp-precomp -fno-strict-aliasing -I/usr/local/include'
     ccversion=3D'', gccversion=3D'3.3 20030304 (Apple Computer, Inc. =20
build 1819)', gccosandvers=3D''
     intsize=3D4, longsize=3D4, ptrsize=3D4, doublesize=3D8, byteorder=3D=
4321
     d_longlong=3Ddefine, longlongsize=3D8, d_longdbl=3Ddefine, longdbl=
size=3D8
     ivtype=3D'long', ivsize=3D4, nvtype=3D'double', nvsize=3D8, =20
Off_t=3D'off_t', lseeksize=3D8
     alignbytes=3D8, prototype=3Ddefine
   Linker and Libraries:
     ld=3D'env MACOSX_DEPLOYMENT_TARGET=3D10.3 cc', ldflags =3D'-L/usr/=
=20
local/lib'
     libpth=3D/usr/local/lib /usr/lib
     libs=3D-ldbm -ldl -lm -lc
     perllibs=3D-ldl -lm -lc
     libc=3D/usr/lib/libc.dylib, so=3Ddylib, useshrplib=3Dtrue, =20
libperl=3Dlibperl.dylib
     gnulibc_version=3D''
   Dynamic Linking:
     dlsrc=3Ddl_dlopen.xs, dlext=3Dbundle, d_dlsymun=3Dundef, ccdlflags=
=3D' '
     cccdlflags=3D' ', lddlflags=3D'-bundle -undefined dynamic_lookup -=
L/=20
usr/local/lib'


Characteristics of this binary (from libperl):
   Compile-time options: MULTIPLICITY USE_ITHREADS USE_LARGE_FILES =20
PERL_IMPLICIT_CONTEXT
   Locally applied patches:
         23953 - fix for File::Path::rmtree CAN-2004-0452 security issu=
e
         33990 - fix for setuid perl security issues
         SPRINTF0 - fixes for sprintf formatting issues - CVE-2005-3962
   Built under darwin
   Compiled at Nov  2 2006 10:37:00
   @INC:
     /System/Library/Perl/5.8.6/darwin-thread-multi-2level
     /System/Library/Perl/5.8.6
     /Library/Perl/5.8.6/darwin-thread-multi-2level
     /Library/Perl/5.8.6
     /Library/Perl
     /Network/Library/Perl/5.8.6/darwin-thread-multi-2level
     /Network/Library/Perl/5.8.6
     /Network/Library/Perl
     /System/Library/Perl/Extras/5.8.6/darwin-thread-multi-2level
     /System/Library/Perl/Extras/5.8.6
     /Library/Perl/5.8.1/darwin-thread-multi-2level
     /Library/Perl/5.8.1
     .


=46ull cvsimport log :

10:17:16: git cvsimport -v
Initialized empty Git repository in /Users/Shared/Developement/=20
=46lexiSheet/.git/
Running cvsps...
cvs_direct initialized to CVSROOT /cvsroot/flexisheet
cvs rlog: Logging FlexiSheet
cvs rlog: Logging FlexiSheet/Application
cvs rlog: Logging FlexiSheet/Application/ChartView
cvs rlog: Logging FlexiSheet/Application/CompressedSaving
cvs rlog: Logging FlexiSheet/Application/English.lproj
cvs rlog: Logging FlexiSheet/Application/English.lproj/=20
DocumentInspector.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/Export.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/FSChart.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/FSTable.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/Functions.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/Import.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/Inspector.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/ItemInspector.ni=
b
cvs rlog: Logging FlexiSheet/Application/English.lproj/MainMenu.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/=20
MultipleSelectionInspector.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/=20
NoSelectionInspector.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/Preferences.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/SortingItems.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/Styles.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/=20
TableInspector.nib
cvs rlog: Logging FlexiSheet/Application/English.lproj/ViewInspector.ni=
b
cvs rlog: Logging FlexiSheet/Application/FlexiSheet Help
cvs rlog: Logging FlexiSheet/Application/FlexiSheet Help/Functions
cvs rlog: Logging FlexiSheet/Application/FlexiSheet Help/Pages
cvs rlog: Logging FlexiSheet/Application/FlexiSheet Help/Topics
cvs rlog: Logging FlexiSheet/Application/FlexiSheet Help/av
cvs rlog: Logging FlexiSheet/Application/German.lproj
cvs rlog: Logging FlexiSheet/Application/German.lproj/MainMenu.nib
cvs rlog: Logging FlexiSheet/Application/Inspection
cvs rlog: Logging FlexiSheet/Application/Scripting
cvs rlog: Logging FlexiSheet/Application/UI
cvs rlog: Logging FlexiSheet/Core
cvs rlog: Logging FlexiSheet/Documentation
cvs rlog: Logging FlexiSheet/FlexiSheet.pbproj
cvs rlog: Logging FlexiSheet/Functions
cvs rlog: Logging FlexiSheet/Images
cvs rlog: Logging FlexiSheet/Operators
cvs rlog: Logging FlexiSheet/Test
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * This is the new License for FlexiSheet.
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        License.txt:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * *** empty log message ***
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        Test/AllTests.h:INITIAL->1.1
* UNKNOWN LINE *        Test/AllTests.m:INITIAL->1.1
* UNKNOWN LINE *        Test/CellTest.h:INITIAL->1.1
* UNKNOWN LINE *        Test/CompareOpTests.m:INITIAL->1.1
* UNKNOWN LINE *        Test/CrossTableFormulaTest.h:INITIAL->1.1
* UNKNOWN LINE *        Test/CrossTableFormulaTest.m:INITIAL->1.1
* UNKNOWN LINE *        Test/FSNumberTests.h:INITIAL->1.1
* UNKNOWN LINE *        Test/FSNumberTests.m:INITIAL->1.1
* UNKNOWN LINE *        Test/FSTestCase.h:INITIAL->1.1
* UNKNOWN LINE *        Test/FSTestCase.m:INITIAL->1.1
* UNKNOWN LINE *        Test/FSTestDocument.h:INITIAL->1.1
* UNKNOWN LINE *        Test/FSTestDocument.m:INITIAL->1.1
* UNKNOWN LINE *        Test/FSUnitTest.m:INITIAL->1.1
* UNKNOWN LINE *        Test/FinancialFunctionsTests.h:INITIAL->1.1
* UNKNOWN LINE *        Test/FinancialFunctionsTests.m:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * FSCore Framework completely checked in.
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        Core/FSConstant.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSConstant.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSCore.h:INITIAL->1.2
* UNKNOWN LINE *        Core/FSDocumentProtocol.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSExpression.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSExpression.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSExpressionError.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSExpressionError.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSExpressionNegator.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSExpressionNegator.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSExpressionParenthesis.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSExpressionParenthesis.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSFormula.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSFormula.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSFormulaDefinition.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSFormulaDefinition.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSFormulaSelection.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSFormulaSelection.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSFormulaSpace.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSFormulaSpace.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSGlobalHeader.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSGlobalHeader.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSHashMap.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSHashMap.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSHeader.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSHeader.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSKey.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSKey.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSKeyGroup.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSKeyGroup.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSKeyRange.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSKeyRange.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSKeySet.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSKeySet.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSLog.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSLog.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSObject.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSObject.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSOperator.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSOperator.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSParserFunctions.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSParserFunctions.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSSelection.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSSelection.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSTable+Find.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSTable+Formula.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSTable.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSTable.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSTypes.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSUnit.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSUnit.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSValue.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSValue.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FSVariable.h:INITIAL->1.1
* UNKNOWN LINE *        Core/FSVariable.m:INITIAL->1.1
* UNKNOWN LINE *        Core/FoundationExtentions.h:INITIAL->1.2
* UNKNOWN LINE *        Core/FoundationExtentions.m:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * PBX Project File.  Requires Xcode 1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        FlexiSheet.pbproj/project.pbxproj:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * *** empty log message ***
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        Images/AlertIcon.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/Application.icns:INITIAL->1.1
* UNKNOWN LINE *        Images/BlackLeftArrow.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/BlackRightArrow.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/ChartSmIcon.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/ClosedGrabHandCursor.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/CornerMenu.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/Document.icns:INITIAL->1.1
* UNKNOWN LINE *        Images/FTEqualSign.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/FTIfBlock.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/FormulaError.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/FormulaOK.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/FormulaWarning.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/HorzResizeCursor.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/OpenGrabHandCursor.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/Sheet.icns:INITIAL->1.1
* UNKNOWN LINE *        Images/TBAttach.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TBDelete.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TBEdit.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TBFind.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TBFormula.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TBInspect.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TBRecalc.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TBRedo.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TBRevert.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TBSaveDocument.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TBUndo.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TB_Documents.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TB_Lock_0.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TB_Lock_1.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TB_Settings.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TB_Stop.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TViewSmIcon.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/TableSmIcon.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/VertResizeCursor.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/centeralign_nib.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/fingerCursor.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/justifyalign_nib.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/ldock-6.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/leftalign_nib.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/lempty-6.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/mdock-6.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/mempty-6.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/naturalalign_nib.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/rdock-6.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/rempty-6.tiff:INITIAL->1.1
* UNKNOWN LINE *        Images/rightalign_nib.tiff:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * *** empty log message ***
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        Test/CellTest.m:INITIAL->1.2
* UNKNOWN LINE *        Test/CompareOpTests.h:INITIAL->1.2
* UNKNOWN LINE *        Test/FSTestObserver.h:INITIAL->1.2
* UNKNOWN LINE *        Test/FSTestObserver.m:INITIAL->1.2
* UNKNOWN LINE *        Test/GroupFunctionsTests.h:INITIAL->1.1
* UNKNOWN LINE *        Test/GroupFunctionsTests.m:INITIAL->1.1
* UNKNOWN LINE *        Test/HashMapTest.h:INITIAL->1.1
* UNKNOWN LINE *        Test/HashMapTest.m:INITIAL->1.1
* UNKNOWN LINE *        Test/ItemGroupTest.h:INITIAL->1.1
* UNKNOWN LINE *        Test/ItemGroupTest.m:INITIAL->1.1
* UNKNOWN LINE *        Test/KeysetCreationTest.h:INITIAL->1.1
* UNKNOWN LINE *        Test/KeysetCreationTest.m:INITIAL->1.1
* UNKNOWN LINE *        Test/LinkedCategoriesTest.h:INITIAL->1.1
* UNKNOWN LINE *        Test/LinkedCategoriesTest.m:INITIAL->1.1
* UNKNOWN LINE *        Test/NameArchiveTest.h:INITIAL->1.1
* UNKNOWN LINE *        Test/NameArchiveTest.m:INITIAL->1.1
* UNKNOWN LINE *        Test/OperatorTests.h:INITIAL->1.1
* UNKNOWN LINE *        Test/OperatorTests.m:INITIAL->1.1
* UNKNOWN LINE *        Test/SortingTests.h:INITIAL->1.1
* UNKNOWN LINE *        Test/SortingTests.m:INITIAL->1.1
* UNKNOWN LINE *        Test/StringQuotingTest.h:INITIAL->1.1
* UNKNOWN LINE *        Test/StringQuotingTest.m:INITIAL->1.1
* UNKNOWN LINE *        Test/UndoTests.h:INITIAL->1.1
* UNKNOWN LINE *        Test/UndoTests.m:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * *** empty log message ***
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        Application/main.m:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * *** empty log message ***
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        Operators/FSCatOperator.h:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSCatOperator.m:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSDivideOperator.h:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSDivideOperator.m:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSEqualOperator.h:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSEqualOperator.m:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSMinusOperator.h:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSMinusOperator.m:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSMultiplyOperator.h:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSMultiplyOperator.m:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSPlusOperator.h:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSPlusOperator.m:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSPowOperator.h:INITIAL->1.1
* UNKNOWN LINE *        Operators/FSPowOperator.m:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * *** empty log message ***
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        Functions/FSAbsFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSAbsFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSCellnameFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSCellnameFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSCorrelFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSCorrelFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSCosFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSCosFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSFinancialFunctions.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSFinancialFunctions.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSIfFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSIfFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSLnFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSLnFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSLogFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSLogFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSMaxFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSMaxFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSMinFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSMinFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSPIFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSPIFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSProdFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSProdFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSRandFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSRandFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSSignFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSSignFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSSinFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSSinFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSSqrtFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSSqrtFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSStringFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSStringFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSSumFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSSumFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSTanFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSTanFunction.m:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSTodayFunction.h:INITIAL->1.1
* UNKNOWN LINE *        Functions/FSTodayFunction.m:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * temporary application classes
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        Application/FSArchiving.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSArchiving.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSCellStyle.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSCellStyle.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSController.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSController.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSDocument+Printing.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSDocument+Quantrix.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSDocument+Scripting.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSDocument.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSDocument.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSExporter.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSExporter.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSFirstResponder.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSFunctionHelp.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSFunctionHelp.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSGraffleExport.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSGraffleExport.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSHeaderLayout.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSHeaderLayout.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSImporter.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSImporter.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSPasteboardHandling.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSPasteboardHandling.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSPreferences.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSPreferences.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSSortPanelController.h:INITIAL->1.=
1
* UNKNOWN LINE *        Application/FSSortPanelController.m:INITIAL->1.=
1
* UNKNOWN LINE *        Application/FSTableController=20
+Formula.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSTableController=20
+Toolbar.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSTableController.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSTableController.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSTableTabs.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSTableTabs.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSWindowController.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSWindowController.m:INITIAL->1.1
* UNKNOWN LINE *        Application/FSWorksheet.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FSWorksheet.m:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * *** empty log message ***
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        TODO:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet.h:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet.scriptSuite:INITIAL->1.1
* UNKNOWN LINE *        Application/version.plist:INITIAL->1.1
* UNKNOWN LINE *        Application/ChartView/=20
=46SChartController.h:INITIAL->1.1
* UNKNOWN LINE *        Application/ChartView/=20
=46SChartController.m:INITIAL->1.1
* UNKNOWN LINE *        Application/ChartView/FSChartView.h:INITIAL->1.=
1
* UNKNOWN LINE *        Application/ChartView/FSChartView.m:INITIAL->1.=
1
* UNKNOWN LINE *        Application/CompressedSaving/bzlib.h:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Application/CompressedSaving/libbz2.a:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Application/English.lproj/Credits.rtf:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Application/English.lproj/=20
=46lexiSheet.scriptTerminology:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
InfoPlist.strings:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
Localizable.strings:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
DocumentInspector.nib/classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
DocumentInspector.nib/info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
DocumentInspector.nib/objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Export.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Export.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Export.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/FSTable.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/FSTable.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/FSTable.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Functions.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Functions.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Functions.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/MainMenu.nib/=20
JavaCompiling.plist:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/MainMenu.nib/=20
_MainMenu_EOArchive_English.java:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/MainMenu.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/MainMenu.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/MainMenu.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
MultipleSelectionInspector.nib/classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
MultipleSelectionInspector.nib/info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
MultipleSelectionInspector.nib/objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Styles.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Styles.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Styles.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/=20
index.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/=20
toc_OpenSave.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/=20
toc_Start.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/=20
toc_Working.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
AbsFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
AvgFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
CellnameFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
CountFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
CtermFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
=46vFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
GroupSumFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
IfFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
LnFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
LogFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
MaxFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
MinFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
PaymentFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
PiFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
ProdFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
RandFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
RateFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
SelectFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
SignFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
SinFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
SqrtFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
StringFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
SumFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Functions/=20
TodayFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
AddingCategory.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
DescribeViewTable.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
=46unctionOverview.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
GroupSumFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
MoveCategories.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
NameCategories.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
OperatorOverview.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
RenamingCategory.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
SavingChanges.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
TopicTemplate.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Pages/=20
WorkWithCategories.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Topics/=20
Concept.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Topics/=20
DesigningAModel.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Topics/=20
=46ormulaArea.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Topics/=20
=46ormulaList.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Topics/=20
=46ormulaStructure.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Topics/=20
Template.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/Topics/=20
WritingFormulas.html:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
1PixelRule.tiff:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
3PixelRule.tiff:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/AreaYear-=20
QuarterTable.png:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
Back.tiff:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
CheckMark.tiff:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
=46lexiSheet.png:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
=46orward.tiff:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/Year-=20
QuarterTable.png:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/YearQuarter-=20
AreaTable.png:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
appicon.png:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
appicon128.tiff:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
appicon64.jpg:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
bookIcon.gif:INITIAL->1.1
* UNKNOWN LINE *        Application/FlexiSheet Help/av/=20
navbackground.gif:INITIAL->1.1
* UNKNOWN LINE *        Application/German.lproj/=20
InfoPlist.strings:INITIAL->1.1
* UNKNOWN LINE *        Application/German.lproj/MainMenu.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/German.lproj/MainMenu.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/German.lproj/MainMenu.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SCellInspectorPane.h:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SCellInspectorPane.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SDocumentInspectorPane.h:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SDocumentInspectorPane.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/FSInspection.h:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Application/Inspection/FSInspection.m:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Application/Inspection/FSInspector.h:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Application/Inspection/FSInspector.m:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SInspectorPane.h:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SInspectorPane.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SItemInspectorPane.h:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SItemInspectorPane.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SMultipleSelectionInspectorPane.h:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SMultipleSelectionInspectorPane.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SNoSelectionInspectorPane.h:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SNoSelectionInspectorPane.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46STableInspectorPane.h:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46STableInspectorPane.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SViewInspectorPane.h:INITIAL->1.1
* UNKNOWN LINE *        Application/Inspection/=20
=46SViewInspectorPane.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Scripting/FSHeader=20
+Scripting.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Scripting/FSKey=20
+Scripting.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Scripting/FSKeySet=20
+Scripting.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Scripting/FSTable=20
+Scripting.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Scripting/FSValue=20
+Scripting.m:INITIAL->1.1
* UNKNOWN LINE *        Application/Scripting/FSWorksheet=20
+Scripting.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSFormulaTable.h:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSFormulaTable.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSHeaderDock.h:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSHeaderDock.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSMatrix.h:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSMatrix.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSMatrixDataSource.h:INITIAL->1.=
1
* UNKNOWN LINE *        Application/UI/FSTableView+Keyboard.m:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Application/UI/FSTableView+Layout.m:INITIAL->1.=
1
* UNKNOWN LINE *        Application/UI/FSTableView=20
+Scrolling.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSTableView=20
+Selection.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSTableView.h:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSTableView.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSVarioMatrix.h:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/FSVarioMatrix.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/ImageAndTextCell.h:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/ImageAndTextCell.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/SLCornerMenu.h:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/SLCornerMenu.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/SLFloatingMark.h:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/SLFloatingMark.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/SLOutlineView.h:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/SLOutlineView.m:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/SLSplashScreen.h:INITIAL->1.1
* UNKNOWN LINE *        Application/UI/SLSplashScreen.m:INITIAL->1.1
* UNKNOWN LINE *        Documentation/AllTests.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSAbsFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSAcosFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSAsinFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSAtanFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSAvgFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSCatOperator.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SCellInspectorPane.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSCellStyle.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSCellnameFunction.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSChartController.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSChartView.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSConstant.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSController.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSCosFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSCoshFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSCountFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSCtermFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSDataStore.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSDdbFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSDivideOperator.html:INITIAL->1.=
1
* UNKNOWN LINE *        Documentation/FSDocument=20
+Archiving.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSDocument=20
+FSInspectable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSDocument=20
+Spreadsheet.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSDocument.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SDocumentInspectorPane.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSDocumentProtocol.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/=20
=46SEditableSelectionProtocol.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSEqualOperator.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSExpression.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSExpressionError.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/=20
=46SExpressionNegator.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SExpressionParenthesis.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SFirstResponderProtocol.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSFormula.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SFormulaDefinition.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSFormulaSelection.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSFormulaSpace.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSFormulaTable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSFunctionHelp.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSFvFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSGTEqualOperator.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSGlobalHeader.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSGroupsumFunction.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSHeader=20
+FSInspectable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSHeader.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSHeaderDock.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSIfFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSImporter.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SInspectableProtocol.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SInspectableSelection.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SInspectableStyleProtocol.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSInspector.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSInspectorPane.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSIrrFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSItemProtocol.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSKey+Archiving.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSKey=20
+FSInspectable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSKey.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSKeyGroup=20
+Archiving.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSKeyGroup=20
+FSInspectable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSKeyGroup=20
+PasteboardHandling.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSKeyGroup.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSKeyRange.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSKeySet+Archiving.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSKeySet.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSKeySetSelection.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSLTEqualOperator.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSLabel.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSLnFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSLog.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSLogFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSMatrix.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SMatrixDataSourceProtocol.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSMaxFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSMinFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSMinusOperator.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSMultiArray.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SMultipleSelectionInspectorPane.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSMultiplyOperator.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/=20
=46SNoSelectionInspectorPane.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSNpvFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSOperator.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSPIFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSPaymentFunction.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSPlusOperator.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSPowOperator.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSPreferences.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSProdFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSRandFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSRateFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSSelection=20
+FSInspectable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSSelection.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSSignFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSSinFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSSinhFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSSlnFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSSqrtFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSStringFunction.html:INITIAL->1.=
1
* UNKNOWN LINE *        Documentation/FSSumFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSSydFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTable+Archiving.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSTable=20
+FSInspectable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTable=20
+ParsingAdditions.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTableController=20
+FormulaEditing.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTableController.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/=20
=46STableInspectorPane.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTableTabs.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTableView+Layout.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSTableView=20
+Scrolling.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTableView=20
+Selection.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTableView.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTanFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTanhFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTermFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTestDocument.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTestObserver.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSTodayFunction.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSUnit.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSValue+Archiving.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/FSValue=20
+FSInspectable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSValue=20
+UnitSupport.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSValue.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSVariable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSVarioMatrix.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SVarioMatrixDataSourceProtocol.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/=20
=46SViewInspectorPane.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSWindowController=20
+Archiving.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSWindowController=20
+FSFirstResponder.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSWindowController=20
+FSInspectable.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/FSWindowController.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/ImageAndTextCell.html:INITIAL->1.=
1
* UNKNOWN LINE *        Documentation/ItemGroupTest.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/NSArray+Archiving.html:INITIAL-=20
 >1.1
* UNKNOWN LINE *        Documentation/NSArray=20
+FoundationExtentions.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/NSMutableArray=20
+FoundationExtentions.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/NSObject=20
+FSMatrixDelegate.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/NSObject=20
+FSTableDataSource.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/NSObject=20
+Introspection.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/NSString=20
+FoundationExtentions.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/SLCornerMenu.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/SLFloatingMark.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/SLOutlineView.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/SLSplashScreen.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/UndoTests.html:INITIAL->1.1
* UNKNOWN LINE *        Documentation/bzlib.html:INITIAL->1.1
* UNKNOWN LINE *        Images/Splash.png:INITIAL->1.1
* UNKNOWN LINE *        Images/splimg.png:INITIAL->1.1
* UNKNOWN LINE *
* UNKNOWN LINE * Tags:
* UNKNOWN LINE * Log:
* UNKNOWN LINE * Missing nib files added.
* UNKNOWN LINE *
* UNKNOWN LINE * Members:
* UNKNOWN LINE *        Application/English.lproj/FSChart.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/FSChart.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/FSChart.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Import.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Import.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Import.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Inspector.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Inspector.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Inspector.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/ItemInspector.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/ItemInspector.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/ItemInspector.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
NoSelectionInspector.nib/classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
NoSelectionInspector.nib/info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/=20
NoSelectionInspector.nib/objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Preferences.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Preferences.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/Preferences.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/SortingItems.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/SortingItems.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/SortingItems.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/TableInspector.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/TableInspector.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/TableInspector.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/ViewInspector.nib/=20
classes.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/ViewInspector.nib/=20
info.nib:INITIAL->1.1
* UNKNOWN LINE *        Application/English.lproj/ViewInspector.nib/=20
objects.nib:INITIAL->1.1
* UNKNOWN LINE *
fatal: Not a valid object name refs/heads/HEAD
read-tree failed: 32768
10:23:08: ls -laR .git
total 32
drwxr-xr-x   11 jfv  wheel  374 31 ao=FB 10:23 .
drwxr-xr-x   14 jfv  wheel  476 31 ao=FB 10:23 ..
-rw-r--r--    1 jfv  wheel   23 31 ao=FB 10:23 HEAD
drwxr-xr-x    2 jfv  wheel   68 31 ao=FB 10:23 branches
-rw-r--r--    1 jfv  wheel   92 31 ao=FB 10:23 config
-rw-r--r--    1 jfv  wheel   58 31 ao=FB 10:23 description
drwxr-xr-x   11 jfv  wheel  374 31 ao=FB 10:23 hooks
-rw-r--r--    1 jfv  wheel   32 31 ao=FB 10:23 index
drwxr-xr-x    3 jfv  wheel  102 31 ao=FB 10:23 info
drwxr-xr-x    4 jfv  wheel  136 31 ao=FB 10:23 objects
drwxr-xr-x    4 jfv  wheel  136 31 ao=FB 10:23 refs

=2Egit/branches:
total 0
drwxr-xr-x    2 jfv  wheel   68 31 ao=FB 10:23 .
drwxr-xr-x   11 jfv  wheel  374 31 ao=FB 10:23 ..

=2Egit/hooks:
total 80
drwxr-xr-x   11 jfv  wheel   374 31 ao=FB 10:23 .
drwxr-xr-x   11 jfv  wheel   374 31 ao=FB 10:23 ..
-rw-r--r--    1 jfv  wheel   441 31 ao=FB 10:23 applypatch-msg
-rw-r--r--    1 jfv  wheel   780 31 ao=FB 10:23 commit-msg
-rw-r--r--    1 jfv  wheel   152 31 ao=FB 10:23 post-commit
-rw-r--r--    1 jfv  wheel   510 31 ao=FB 10:23 post-receive
-rw-r--r--    1 jfv  wheel   207 31 ao=FB 10:23 post-update
-rw-r--r--    1 jfv  wheel   387 31 ao=FB 10:23 pre-applypatch
-rw-r--r--    1 jfv  wheel  1695 31 ao=FB 10:23 pre-commit
-rw-r--r--    1 jfv  wheel  4262 31 ao=FB 10:23 pre-rebase
-rw-r--r--    1 jfv  wheel  1949 31 ao=FB 10:23 update

=2Egit/info:
total 8
drwxr-xr-x    3 jfv  wheel  102 31 ao=FB 10:23 .
drwxr-xr-x   11 jfv  wheel  374 31 ao=FB 10:23 ..
-rw-r--r--    1 jfv  wheel  240 31 ao=FB 10:23 exclude

=2Egit/objects:
total 0
drwxr-xr-x    4 jfv  wheel  136 31 ao=FB 10:23 .
drwxr-xr-x   11 jfv  wheel  374 31 ao=FB 10:23 ..
drwxr-xr-x    2 jfv  wheel   68 31 ao=FB 10:23 info
drwxr-xr-x    2 jfv  wheel   68 31 ao=FB 10:23 pack

=2Egit/objects/info:
total 0
drwxr-xr-x   2 jfv  wheel   68 31 ao=FB 10:23 .
drwxr-xr-x   4 jfv  wheel  136 31 ao=FB 10:23 ..

=2Egit/objects/pack:
total 0
drwxr-xr-x   2 jfv  wheel   68 31 ao=FB 10:23 .
drwxr-xr-x   4 jfv  wheel  136 31 ao=FB 10:23 ..

=2Egit/refs:
total 0
drwxr-xr-x    4 jfv  wheel  136 31 ao=FB 10:23 .
drwxr-xr-x   11 jfv  wheel  374 31 ao=FB 10:23 ..
drwxr-xr-x    2 jfv  wheel   68 31 ao=FB 10:23 heads
drwxr-xr-x    2 jfv  wheel   68 31 ao=FB 10:23 tags

=2Egit/refs/heads:
total 0
drwxr-xr-x   2 jfv  wheel   68 31 ao=FB 10:23 .
drwxr-xr-x   4 jfv  wheel  136 31 ao=FB 10:23 ..

=2Egit/refs/tags:
total 0
drwxr-xr-x   2 jfv  wheel   68 31 ao=FB 10:23 .
drwxr-xr-x   4 jfv  wheel  136 31 ao=FB 10:23 ..
10:23:54:
